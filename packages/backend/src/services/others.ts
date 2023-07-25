import type { OtherRepository } from '@repositories';
import type { OtherResponseDto,CreateProduct } from '@vse-bude/shared';
import {
  ProductNotFoundError,
  UnauthorizedError,
  AuctionEndedError,
  FieldError,
  NotVerifiedError,
  AlreadyLeftAuctionError,
} from '@errors';
import { createPostSchema, updatePostSchema } from 'validation/product/schemas';
import type { AllProductsResponse, ProductById } from '@types';
import type {
  AuctionScheduler,
  VerifyService,
  S3StorageService,
  NotificationService,
} from '@services';
import { ProductType, NotificationType } from '@vse-bude/shared';
import { ProductStatus } from '@prisma/client';
import { productMapper, auctionPermissionsMapper } from '@mappers';
// import { lang } from '@lang';

export class OtherService {
  private _otherRepository: OtherRepository;
  private _verifyService: VerifyService;
  private _auctionScheduler: AuctionScheduler;
  

  constructor(otherRepository: OtherRepository) {
    this._otherRepository = otherRepository;
  }
  

  public async getAll(): Promise<OtherResponseDto[]> {
    const result = await this._otherRepository.getAll();
    return result;
  }
  
  private isAuctionProduct(type: string): boolean {
    return type === ProductType.AUCTION;
  }
  
  public async createProduct({
    req,
    userId,
    fieldsData,
  }: CreateProduct): Promise<ProductById> {
    const { error } = createPostSchema.validate(req.body);
    if (error) {
      throw new FieldError(error.message);
    }
    console.log(userId)
    // const isUserVerified = await this._verifyService.isUserVerified(userId);
    // console.log(isUserVerified)
    // if (!isUserVerified) {
    //   throw new NotVerifiedError();
    // }
    // const imageLinks = await this._s3StorageService.uploadProductImages(req);
    const imageLinks=""
    
    if (fieldsData.type === ProductType.AUCTION) {
      fieldsData.price = fieldsData.recommendedPrice;
    }
    if (fieldsData.status !== ProductStatus.DRAFT) {
      fieldsData.postDate = new Date().toISOString();
    }
    const data = {
      imageLinks,
      authorId: userId,
      ...fieldsData,
    };
    console.log('create others')
    
    const product = await this._otherRepository.create(data);

    if (this.isAuctionProduct(product.type)) {
      this._auctionScheduler.createAuctionJob(product);
    }

    return productMapper(product);
  }
}
