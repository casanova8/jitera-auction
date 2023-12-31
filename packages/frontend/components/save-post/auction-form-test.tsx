import { useTranslation } from 'next-i18next';
import { useForm, Controller } from 'react-hook-form';
import { Input, Column, Flex, Button, Loader, InputDate } from '@primitives';
import { useState, useEffect } from 'react';
import { joiResolver } from '@hookform/resolvers/joi';
import { useTypedSelector } from '@hooks';
import { useRouter } from 'next/router';
import { updateProduct } from 'services/product';
import { createPost } from 'services/post';
import { ProductType } from '@vse-bude/shared';
import { ProfileRoutes, Routes } from '@enums';
import type { SelectOption } from '@components/primitives/select/types';
import { createAuctionSchema } from 'validation-schemas/post';
import { initialAuctionFormState, ConditionFields } from './form-utils';
import ImageInput from './image-input';
import DescriptionBlock from './description';
import * as styles from './styles';
import ContactBlock from './contact';
import type { registerFieldType, setValueType } from './types';
import { PostStatuses } from './types';
import { Select } from '@components/primitives/select';
import { Textarea } from 'components/primitives/textarea';
import { SectionHeader } from '@components/profile/user-account/common';
import type { CategoryDto } from '@vse-bude/shared';

export default function ProductForm({ edit }: { edit: boolean }) {
  const { query, push } = useRouter();
  const { t } = useTranslation();
  const currentProduct = useTypedSelector((state) => state.product.currentItem);
  const categories = useTypedSelector((state) => state.category.list);
  const [category, setCategory] = useState<SelectOption>(null);
  const [condition, setCondition] = useState<SelectOption>(null);
  const [images, setImages] = useState<(File | string)[]>([]);
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [status, setStatus] = useState(PostStatuses.CREATE);
  const [endDate, setEndDate] = useState(null);
  const {
    register,
    handleSubmit,
    formState: { errors },
    setValue,
    control,
  } = useForm({
    defaultValues: initialAuctionFormState,
    resolver: joiResolver(createAuctionSchema(t)),
  });

  const onSubmit = async (data) => {
    if (isLoading) return;
    if (images.length < 2) {
      setError(t('create-post:validation.images.few'));

      return;
    }
    if (images.length > 30) {
      setError(t('create-post:validation.images.many'));

      return;
    }

    setIsLoading(true);
    setError('');
    try {
      const formData = new FormData();
      images.forEach((file) => formData.append('images', file));
      formData.append('type', ProductType.AUCTION);
      formData.append('status', status);

      Object.keys(data).forEach((key) => {
        switch (key) {
          case 'category':
            formData.append(key, category.value);
            break;
          case 'condition':
            formData.append(key, condition.value);
            break;
          case 'phone':
            formData.append(key, data[key] ? `+380${data[key]}` : '');
            break;
          default:
            formData.append(key, data[key] ?? '');
        }
      });
      formData.set('endDate', data.endDate.toISOString());

      if (edit) {
        const editInfo = await updateProduct(query.id as string, formData);
        editInfo && push(`${Routes.PROFILE}/${ProfileRoutes.LIST}`);
      } else {
        const { id } = await createPost(formData);
        id && push(`${Routes.PROFILE}/${ProfileRoutes.LIST}`);
      }
    } catch (error) {
      if (error instanceof Error) {
        setError(error.message);
      }

      return;
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    if (edit && currentProduct && categories.length > 0 && !isLoading) {
      Object.keys(initialAuctionFormState).forEach((item) => {
        switch (item) {
          case 'category': {
            const currentCategory = categories.find(
              (item) => item.id === currentProduct.category?.id,
            );
            setValue(item, currentCategory?.title);
            setCategory({
              value: currentCategory?.id,
              title: currentCategory?.title,
            });
            break;
          }
          case 'condition': {
            setValue('condition', currentProduct?.condition);
            setCondition(ConditionFields(t)[currentProduct?.condition]);
            break;
          }
          case 'endDate':
            setValue(item, new Date(currentProduct?.endDate).toISOString());
            setEndDate(new Date(currentProduct?.endDate));
            break;
          case 'phone':
            setValue('phone', currentProduct.phone.replace('+380', ''));
            break;
          case 'currency':
            setValue('currency', 'USD');
            break;
          default:
            setValue(item as 'title', currentProduct[item]);
        }
      });
      setImages(currentProduct.imageLinks);
    }
  }, [currentProduct, setValue, edit, categories, isLoading, t]);

  const setCategoryWrapper = (category: SelectOption) => {
    setCategory(category);
    setValue('category', category.value);
  };

  const setConditionWrapper = (condition: SelectOption) => {
    setCondition(condition);
    setValue('condition', condition.value);
  };

  return (
    <form noValidate onSubmit={handleSubmit(onSubmit)}>
      <ImageInput images={images} setImages={setImages} />
      <Column css={styles.sectionRow}>
        {/* <DescriptionBlock
          category={category}
          condition={condition}
          register={register as registerFieldType}
          setCategories={setCategoryWrapper}
          setCondition={setConditionWrapper}
          errors={errors}
        /> */}
        <>
      <SectionHeader>{t('create-post:headline.description')}</SectionHeader>
      <div css={styles.inputRow}>
        <Select
          labelRequiredMark
          required
          options={categories.map((item: CategoryDto) => ({
            title: item.title,
            value: item.id,
          }))}
          value={category?.title}
          setValue={setCategoryWrapper}
          id="post-category"
          name="category"
          label={t('create-post:label.category')}
          placeholder={t('create-post:placeholder.category')}
          error={errors.category?.message}
        />
      </div>
      <div css={styles.inputRow}>
        <Input
          labelRequiredMark
          error={errors.title?.message}
          required
          id="post-title"
          type="text"
          name="title"
          variant="primary"
          label={t('create-post:label.name')}
          placeholder={t('create-post:placeholder.name')}
          {...register('title')}
        />
      </div>
      <div css={styles.inputRow}>
        <Textarea
          labelRequiredMark
          error={errors.description?.message}
          required
          id="post-description"
          name="description"
          label={t('create-post:label.description')}
          placeholder={t('create-post:placeholder.description')}
          {...register('description')}
        />
      </div>
      <div css={styles.inputRow}>
        <Select
          labelRequiredMark
          required
          options={Object.values(ConditionFields(t))}
          value={condition?.title}
          setValue={setConditionWrapper}
          id="post-condition"
          name="condition"
          label={t('create-post:label.condition')}
          placeholder={t('create-post:placeholder.condition')}
          error={errors.condition?.message}
          cssDropdownExtend={styles.conditionSelect}
        />
      </div>
    </>
        <Flex css={styles.groupInputs}>
          <div css={styles.smallInputRow}>
            <Input
              disabled
              id="post-currency"
              type="text"
              name="currency"
              variant="primary"
              label={t('create-post:label.currency')}
              value={t('create-post:placeholder.currency')}
              {...register('recommendedPriceCurrency')}
            />
          </div>
          <div css={styles.inputRow}>
            <Input
              error={errors.recommendedPrice?.message}
              labelRequiredMark
              id="post-price"
              type="number"
              name="price"
              variant="primary"
              label={t('create-post:label.recommendedPrice')}
              placeholder={t('create-post:placeholder.recommendedPrice')}
              tooltip={t('create-post:tooltip.recommendedPrice')}
              {...register('recommendedPrice')}
            />
          </div>
        </Flex>
        <Flex css={styles.groupInputs}>
          <div css={styles.smallInputRow}>
            <Input
              disabled
              id="post-minimal-bid-currency"
              type="text"
              name="minimal-bid-currency"
              variant="primary"
              label={t('create-post:label.currency')}
              value={t('create-post:placeholder.currency')}
              {...register('minimalBidCurrency')}
            />
          </div>
          <div css={styles.inputRow}>
            <Input
              error={errors.minimalBid?.message}
              labelRequiredMark
              id="post-price"
              type="number"
              name="price"
              variant="primary"
              label={t('create-post:label.minimalBid')}
              placeholder={t('create-post:placeholder.minimalBid')}
              tooltip={t('create-post:tooltip.minimalBid')}
              {...register('minimalBid')}
            />
          </div>
        </Flex>
        <Controller
          control={control}
          name="endDate"
          render={({ field }) => (
            <InputDate
              labelRequiredMark
              required
              variant="primary"
              label={t('create-post:label.endDate')}
              id="post-end-date"
              error={errors.endDate?.message}
              selected={endDate}
              value={endDate}
              showTimeInput
              onChange={(date) => {
                console.log(date);
                setEndDate(date);
                field.onChange(date);
              }}
            />
          )}
        />
      </Column>
      <Column>
        <ContactBlock
          setValue={setValue as setValueType}
          register={register as registerFieldType}
          errors={errors}
        />
      </Column>
      {error && <p css={styles.photosError}>{error}</p>}

      <div css={styles.btnWrapper}>
        {isLoading && (
          <div css={styles.formLoader}>
            <Loader size="big" />
          </div>
        )}
        <div css={styles.saveDraftBtn}>
          {(!edit || currentProduct.status === PostStatuses.DRAFT) && (
            <Button
              onClick={() => setStatus(PostStatuses.DRAFT)}
              type="submit"
              disabled={isLoading}
              variant="outlined"
            >
              {t('create-post:button.saveDraft')}
            </Button>
          )}
        </div>
        <Button
          onClick={() => setStatus(PostStatuses.CREATE)}
          disabled={isLoading}
          type="submit"
        >
          {edit
            ? t('create-post:button.editPost')
            : t('create-post:button.makePost')}
        </Button>
      </div>
    </form>
  );
}
