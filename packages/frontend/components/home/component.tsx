import { Routes } from '@enums';
import { ProductType } from '@vse-bude/shared';
import { useTranslation } from 'next-i18next';
import React from 'react';
import { CategorySection } from './category-section';
// import { CharitySection } from './charity-section';
import { LotSection } from './lot-section';
// import { PromoSection } from './promo-section';
import type { HomeProps } from './types';

const Home = ({ auctionProducts, sellingProducts }: HomeProps) => {
  const { t } = useTranslation();

  const redirectToFilterByType = (type: ProductType) =>
    encodeURI(`${Routes.ITEMS}?filter={"type":"${type}"}`);

  return (
    <React.Fragment>
      <CategorySection />
      <LotSection
        title={t('home:popularLots.title')}
        lots={auctionProducts}
        loadMoreTitle={t('home:popularLots.link')}
        loadImageHighPriority
        loadMoreHref={redirectToFilterByType(ProductType.AUCTION)}
      />

      <LotSection
        title={t('home:popularItems.title')}
        lots={sellingProducts}
        loadMoreTitle={t('home:popularItems.link')}
        loadMoreHref={redirectToFilterByType(ProductType.SELLING)}
      />
    </React.Fragment>
  );
};

export { Home };
