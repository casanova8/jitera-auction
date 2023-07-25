import { wrapper } from 'store';
import { serverSideTranslations } from 'next-i18next/serverSideTranslations';
import { Layout } from '@components/layout';
import { SavePostTest } from '@components/save-post';
import type { TestResponseDto, UserResponseDto } from '@vse-bude/shared';
import { Http, ProductType } from '@vse-bude/shared';
import { withPublic } from '@hocs';
import { getCurrentUserSSR } from 'store/auth';
import { AuthHelper, CookieStorage } from '@helpers';
import { Routes } from '@enums';

export const getServerSideProps = withPublic(
  wrapper.getServerSideProps((store) => async (ctx) => {
    const { locale } = ctx;

    const cookieStorage = new CookieStorage(ctx);
    const auth = new AuthHelper(cookieStorage);
    const http = new Http(process.env.NEXT_PUBLIC_API_ROUTE, locale, auth);

    const { payload } = (await store.dispatch(getCurrentUserSSR(http))) as {
      payload: TestResponseDto;
    };

    if (!payload?.id) {
      return {
        redirect: {
          destination: Routes.NOT_FOUND,
        },
        props: {},
      };
    }

    return {
      props: {
        ...(await serverSideTranslations(locale, [
          'common',
          'create-post',
          'rules',
          'item',
          'public',
          'auth',
        ])),
      },
    };
  }),
);

const CreatePage = () => (
  <Layout title="Create ">
    <SavePostTest type={ProductType.AUCTION} />
  </Layout>
);
export default CreatePage;
