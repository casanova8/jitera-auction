import type { VerifyEmailDto, VerifyPhoneDto } from '@vse-bude/shared';
import { VerificationTypes } from '@vse-bude/shared';
import type { UserRepository } from '@repositories';
import { getEnv, isProduction } from '@helpers';
import { lang } from '@lang';
import { CodeNotFoundError, WrongCodeError } from '@errors';
import type { SaveVerifyCode } from '@types';
import type { RedisStorageService } from './redis-storage';
import type { SMSSenderService } from './sms';
import type { EmailService } from './email';

export class VerifyService {
  private phoneCodeLifeTime = 900000;

  private emailCodeLifeTime = 86400000;

  private _userRepository: UserRepository;

  private _cache: RedisStorageService;

  private _smsService: SMSSenderService;

  private _emailService: EmailService;

  private readonly VERIFY_MASTER_CODE: string;

  constructor(
    userRepository: UserRepository,
    cache: RedisStorageService,
    smsService: SMSSenderService,
    emailService: EmailService,
  ) {
    this._userRepository = userRepository;
    this._cache = cache;
    this._smsService = smsService;
    this._emailService = emailService;
    this.VERIFY_MASTER_CODE = getEnv('VERIFY_MASTER_CODE');
  }

  async verifyPhone(dto: VerifyPhoneDto): Promise<void> {
    if (dto.code === this.VERIFY_MASTER_CODE) {
      await this._userRepository.verifyPhone(dto.userId);

      return;
    }

    const code = await this.getUserCodeByTypeAndCode(dto.userId, dto.type);
    if (!code) {
      throw new CodeNotFoundError();
    }
    if (dto.code !== code) {
      throw new WrongCodeError();
    }

    await this._userRepository.verifyPhone(dto.userId);
    await this.deleteCodeByType(dto.userId, dto.type);
  }

  async initPhoneVerification(
    userId: string,
    type = VerificationTypes.PHONE,
  ): Promise<void> {
    await this.resendPhoneCode(userId, type);
  }

  async verifyEmail(dto: VerifyEmailDto): Promise<void> {
    if (dto.code === this.VERIFY_MASTER_CODE) {
      await this._userRepository.verifyEmail(dto.userId);

      return;
    }

    const code = await this.getUserCodeByTypeAndCode(dto.userId, dto.type);
    if (!code) {
      throw new CodeNotFoundError();
    }
    if (dto.code !== code) {
      throw new WrongCodeError();
    }

    await this._userRepository.verifyEmail(dto.userId);
    await this.deleteCodeByType(dto.userId, dto.type);
  }

  async initEmailVerification(
    userId: string,
    type = VerificationTypes.EMAIL,
  ): Promise<void> {
    await this.resendEmailCode(userId, type);
  }

  async createVerificationCode(
    userId: string,
    type: VerificationTypes,
  ): Promise<string> {
    const code = `${this.generateCode()}`;
    await this.saveCode({
      code,
      type,
      userId,
    });

    return code;
  }

  async resendPhoneCode(
    userId: string,
    type: VerificationTypes,
  ): Promise<boolean> {
    const user = await this._userRepository.getById(userId);
    await this.deleteCodeByType(userId, type);
    const code = await this.createVerificationCode(userId, type);

    if (!isProduction) {
      console.log(`Phone verification code: ${code}`);
    }

    return await this._smsService.send(user.phone, code);
  }

  async resendEmailCode(
    userId: string,
    type: VerificationTypes,
  ): Promise<void> {
    const user = await this._userRepository.getById(userId);
    await this.deleteCodeByType(userId, type);
    const code = await this.createVerificationCode(userId, type);
    console.log(code);
    if (!isProduction) {
      console.log(`Email verification code: ${code}`);
    }

    return await this._emailService.send({
      from: { email: getEnv('APP_EMAIL_FROM'), name: getEnv('APP_NAME') },
      to: [{ email: user.email }],
      subject: lang('translation:mailing.verification.subject'),
      text: `${lang('translation:mailing.verification.body')}${code}`,
    });
  }

  private generateCode(): number {
    const maxLimit = 999999;
    const minLimit = 100000;
    const diff = maxLimit - minLimit;

    return Math.floor(Math.random() * diff + minLimit);
  }

  private getUserCodeByTypeAndCode(
    userId: string,
    type: VerificationTypes,
  ): Promise<string> {
    return this._cache.get(this.getVerificationCodeCacheKey(userId, type));
  }

  private deleteCodeByType(
    userId: string,
    type: VerificationTypes,
  ): Promise<number> {
    return this._cache.del(this.getVerificationCodeCacheKey(userId, type));
  }

  private async saveCode(data: SaveVerifyCode): Promise<string> {
    return this._cache.set(
      this.getVerificationCodeCacheKey(data.userId, data.type),
      data.code,
      this.getLifeTime(data.type),
    );
  }

  private getLifeTime(type: VerificationTypes): number {
    const lifeTimes = {
      [VerificationTypes.PHONE]: this.phoneCodeLifeTime,
      [VerificationTypes.EMAIL]: this.emailCodeLifeTime,
    };

    return lifeTimes[type];
  }

  private getVerificationCodeCacheKey(
    userId: string,
    type: VerificationTypes,
  ): string {
    return `verification_code:user_id:${userId}:type:${type}`;
  }

  public async isUserVerified(userId: string): Promise<boolean> {
    const verifyData = await this._userRepository.getVerified({ userId });
    console.log(verifyData)
    return verifyData.emailVerified && verifyData.phoneVerified;
  }
}
