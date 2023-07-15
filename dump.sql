--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3 (Homebrew)

-- Started on 2023-07-16 05:13:37 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 19911)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 20342)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- TOC entry 950 (class 1247 OID 20330)
-- Name: Condition; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Condition" AS ENUM (
    'NEW',
    'USED'
);


ALTER TYPE public."Condition" OWNER TO postgres;

--
-- TOC entry 896 (class 1247 OID 19942)
-- Name: Languages; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Languages" AS ENUM (
    'EN',
    'UA'
);


ALTER TYPE public."Languages" OWNER TO postgres;

--
-- TOC entry 956 (class 1247 OID 20426)
-- Name: NotificationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."NotificationType" AS ENUM (
    'PRODUCT_SOLD',
    'AUCTION_ENDED',
    'OUTBID',
    'BID_PLACED',
    'INFO',
    'AUCTION_LEFT'
);


ALTER TYPE public."NotificationType" OWNER TO postgres;

--
-- TOC entry 944 (class 1247 OID 20304)
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'CREATED',
    'PAID',
    'DELIVERED',
    'CANCELLED'
);


ALTER TYPE public."OrderStatus" OWNER TO postgres;

--
-- TOC entry 902 (class 1247 OID 19954)
-- Name: ProductStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProductStatus" AS ENUM (
    'CREATED',
    'ACTIVE',
    'CANCELLED',
    'FINISHED',
    'CLOSED',
    'DRAFT',
    'SOLD'
);


ALTER TYPE public."ProductStatus" OWNER TO postgres;

--
-- TOC entry 899 (class 1247 OID 19948)
-- Name: ProductType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProductType" AS ENUM (
    'AUCTION',
    'SELLING'
);


ALTER TYPE public."ProductType" OWNER TO postgres;

--
-- TOC entry 890 (class 1247 OID 19931)
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'USER',
    'ADMIN'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- TOC entry 932 (class 1247 OID 20150)
-- Name: SocialMediaType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SocialMediaType" AS ENUM (
    'FACEBOOK',
    'WEBSITE',
    'INSTAGRAM',
    'LINKEDIN'
);


ALTER TYPE public."SocialMediaType" OWNER TO postgres;

--
-- TOC entry 893 (class 1247 OID 19936)
-- Name: Themes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Themes" AS ENUM (
    'LIGHT',
    'DARK'
);


ALTER TYPE public."Themes" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 20000)
-- Name: Address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Address" (
    country character varying(256),
    region character varying(512),
    city character varying(512),
    address character varying(1024),
    zip character varying(32),
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "userId" uuid,
    "deliveryData" character varying(1024)
);


ALTER TABLE public."Address" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 20032)
-- Name: Bid; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bid" (
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "bidderId" uuid NOT NULL,
    "productId" uuid NOT NULL,
    price money NOT NULL,
    "deletedAt" timestamp(0) without time zone
);


ALTER TABLE public."Bid" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 20016)
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    title character varying(512) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    image character varying(2048) DEFAULT ''::character varying
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20040)
-- Name: Chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Chat" (
    title character varying(256) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "deletedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    id uuid NOT NULL,
    "productId" uuid NOT NULL
);


ALTER TABLE public."Chat" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 20049)
-- Name: ChatMember; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ChatMember" (
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    "chatId" uuid NOT NULL
);


ALTER TABLE public."ChatMember" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20288)
-- Name: FavoriteProducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FavoriteProducts" (
    "userId" uuid NOT NULL,
    "productId" uuid NOT NULL
);


ALTER TABLE public."FavoriteProducts" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20057)
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    text text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "senderId" uuid NOT NULL,
    "chatId" uuid NOT NULL
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20279)
-- Name: News; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."News" (
    id uuid NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    description text NOT NULL,
    image text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."News" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 20437)
-- Name: Notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Notification" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    "productId" uuid,
    type public."NotificationType" NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    link text,
    viewed boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Notification" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20313)
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id uuid NOT NULL,
    "productId" uuid NOT NULL,
    "buyerId" uuid NOT NULL,
    cost money NOT NULL,
    status public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20024)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    title character varying(512) NOT NULL,
    description text NOT NULL,
    city character varying(512),
    type public."ProductType" NOT NULL,
    status public."ProductStatus" NOT NULL,
    "endDate" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "cancelReason" text,
    id uuid NOT NULL,
    price money NOT NULL,
    "recommendedPrice" money,
    "minimalBid" money,
    "imageLinks" character varying(2048)[],
    "authorId" uuid NOT NULL,
    "categoryId" uuid,
    "winnerId" uuid,
    views integer DEFAULT 0 NOT NULL,
    country character varying(512),
    phone character varying(32),
    "postDate" timestamp(3) without time zone,
    condition public."Condition" DEFAULT 'NEW'::public."Condition" NOT NULL,
    "participantsNotified" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 20263)
-- Name: RefreshToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RefreshToken" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    token text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);


ALTER TABLE public."RefreshToken" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20008)
-- Name: SocialMedia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SocialMedia" (
    link character varying(2048) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "socialMedia" public."SocialMediaType" NOT NULL,
    "ownedByUserId" uuid,
    "ownedByProductId" uuid
);


ALTER TABLE public."SocialMedia" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 19921)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    email character varying(256) NOT NULL,
    phone character varying(32),
    "firstName" character varying(256) NOT NULL,
    "lastName" character varying(256) NOT NULL,
    avatar character varying(2048),
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "passwordHash" character varying(256) NOT NULL,
    "emailVerified" boolean DEFAULT false NOT NULL,
    "phoneVerified" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 19989)
-- Name: UserSettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserSettings" (
    language public."Languages" DEFAULT 'UA'::public."Languages",
    theme public."Themes" DEFAULT 'LIGHT'::public."Themes",
    "enableEmailNotifications" boolean DEFAULT true,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    id uuid NOT NULL,
    "userId" uuid NOT NULL
);


ALTER TABLE public."UserSettings" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 19912)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 3805 (class 0 OID 20000)
-- Dependencies: 218
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Address" (country, region, city, address, zip, "createdAt", "updatedAt", id, "userId", "deliveryData") FROM stdin;
Cambridgeshire	South Dakota	West Quentinville	Nolan Prairie	60679	2021-11-04 02:24:59.076	2022-08-11 17:19:36.048	0b0b5683-00ca-4ea4-93bb-aed6c1525461	807f73fb-31b8-4e66-9f74-babc8ee95d94	look towards the horizon and turn right
Bedfordshire	Nebraska	Cormierville	Cyrus Mills	18750-4455	2022-07-31 20:59:16.768	2022-08-11 10:37:04.891	23baf553-e2ff-4d51-b512-7823bcbdac25	b8f594a9-e836-4e25-9979-a56500b21be2	look towards the horizon and turn right
Berkshire	Alabama	East Kyleestead	Rasheed Shores	94012-2217	2021-12-03 09:13:27.244	2022-08-11 19:39:03.137	57fd04de-49e9-42f0-9ddf-91c23c2139d5	f5cf90f8-6943-4e42-b006-03cf9bb707a4	look towards the horizon and turn right
Avon	Colorado	Leonardberg	Jewel Hills	24386	2021-11-28 07:23:58.7	2022-08-11 09:10:28.027	9101d73e-6061-45ff-bf27-68ae1299eb66	47504cdd-55e6-4584-9539-6eef69c6deed	look towards the horizon and turn right
Avon	Iowa	Stracketown	Wehner Park	63137	2021-12-05 00:17:13.033	2022-08-11 13:20:49.157	344c5765-71e2-4d50-b4a5-92bb7fd75118	79946740-1328-414f-bef0-926cb4eb59be	look towards the horizon and turn right
\.


--
-- TOC entry 3809 (class 0 OID 20032)
-- Dependencies: 222
-- Data for Name: Bid; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Bid" ("createdAt", "updatedAt", id, "bidderId", "productId", price, "deletedAt") FROM stdin;
2021-08-27 00:41:44.842	2022-08-11 20:52:41.85	327c25b8-45a0-4ae3-87d1-b8857a40d4a8	807f73fb-31b8-4e66-9f74-babc8ee95d94	e2a5725e-1f06-4e9b-8fee-20b19e7b59e9	$32,682.00	\N
2022-04-22 04:57:28.582	2022-08-11 09:49:23.61	c54b8133-1428-424b-a0d1-2d2b72ae347a	b8f594a9-e836-4e25-9979-a56500b21be2	a620ba08-3d3e-4645-8821-cf791cc273d1	$78,356.00	\N
2022-03-04 00:32:35.918	2022-08-12 01:54:40.537	7a7e315a-a0fd-4496-8562-bded209bf69a	f5cf90f8-6943-4e42-b006-03cf9bb707a4	d2a6980a-e8bd-4512-9008-cead4dd36051	$33,912.00	\N
2022-04-04 18:13:37.145	2022-08-12 03:15:36.61	1022483d-fbec-44a4-afe9-adc321ebde44	47504cdd-55e6-4584-9539-6eef69c6deed	c8688a84-af18-4dfe-8f5a-b7a4396001de	$17,745.00	\N
2022-03-26 11:16:52.663	2022-08-11 18:13:13.203	340927a1-c5d6-4e2e-94af-76553dca0039	79946740-1328-414f-bef0-926cb4eb59be	777783f4-7547-465e-9f18-3f68e4e97ad7	$36,625.00	\N
2022-07-22 16:55:59.029	2022-08-11 08:55:25.349	c65d9194-4bb4-46da-8080-b5e1a70a18dd	807f73fb-31b8-4e66-9f74-babc8ee95d94	896d7916-9e8b-47ca-9819-376d97f70145	$96,302.00	\N
2022-03-29 16:13:03.116	2022-08-11 14:52:37.73	8737f27d-ec15-425e-9190-77d57129133b	b8f594a9-e836-4e25-9979-a56500b21be2	7f15800b-63a1-4675-87eb-f47c38c3392a	$22,755.00	\N
2021-12-05 10:51:33.899	2022-08-11 18:41:44.739	93a590bb-4ad0-4975-ab5c-fb4d42ccf410	f5cf90f8-6943-4e42-b006-03cf9bb707a4	8bb4b345-be26-4a11-ae1e-5578c2560bde	$91,925.00	\N
2022-02-28 10:09:38.679	2022-08-11 21:42:07.691	4223c6dc-9a53-405d-aa0f-3112aef02215	47504cdd-55e6-4584-9539-6eef69c6deed	ce6b2fe9-0c66-4673-a58e-c1e76644da55	$70,406.00	\N
2022-02-27 19:25:33.102	2022-08-11 16:04:25.616	be591814-d197-4a72-b95e-e6317f050eff	79946740-1328-414f-bef0-926cb4eb59be	0b8eb3c1-c769-40f3-82e2-b07d95df1cde	$52,440.00	\N
\.


--
-- TOC entry 3807 (class 0 OID 20016)
-- Dependencies: 220
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (title, "createdAt", "updatedAt", id, image) FROM stdin;
LAPTOPS_AND_PC_CATEGORY_NAME	2022-01-10 12:32:04.287	2022-08-11 08:58:38.557	51dea135-fca2-4cc0-ab5b-a32c909f14e7	https://loremflickr.com/640/480/fashion
SMARTPHONES_TV_AND_ELECTRONICS_CATEGORY_NAME	2021-10-01 23:40:29.411	2022-08-11 15:55:36.742	50d4f365-e241-4783-8b2c-809a7d83771b	https://loremflickr.com/640/480/fashion
GOODS_FOR_GAMERS_CATEGORY_NAME	2022-07-04 07:37:02.657	2022-08-11 21:44:52.611	3f9bd5c0-f9a8-4763-b020-eac58681b1cf	https://loremflickr.com/640/480/fashion
HOUSEHOLD_APPLIANCES_CATEGORY_NAME	2022-01-12 23:49:49.976	2022-08-12 02:32:01.968	0e86f866-2146-4a5a-970b-7a62f07144a6	https://loremflickr.com/640/480/fashion
HOME_GOODS_CATEGORY_NAME	2022-06-26 19:23:03.114	2022-08-11 08:35:06.609	a7694c34-2325-4d0d-b344-0fe074e99862	https://loremflickr.com/640/480/fashion
TOOLS_AND_AUTO_GOODS_CATEGORY_NAME	2021-12-30 14:59:07.037	2022-08-12 00:38:54.4	6b8df3e5-b587-413f-9943-ef3d695b97c0	https://loremflickr.com/640/480/fashion
PLUMBING_AND_REPAIR_CATEGORY_NAME	2021-09-13 17:41:10.534	2022-08-11 20:11:36.956	e4bef890-791e-4c53-adfd-c455227b54ad	https://loremflickr.com/640/480/fashion
COTTAGE_GARDEN_AND_VEGETABLE_GARDEN_CATEGORY_NAME	2022-06-06 00:47:34.992	2022-08-12 06:10:46.774	beff46f0-133b-4af7-8206-83419b526734	https://loremflickr.com/640/480/fashion
SPORTS_AND_HOBBY_CATEGORY_NAME	2022-04-11 22:08:14.925	2022-08-11 12:41:20.152	a351b320-76d7-4545-bb74-8bb1f2fa486d	https://loremflickr.com/640/480/fashion
CLOTHES_SHOES_AND_JEWELRY_CATEGORY_NAME	2021-11-10 15:41:32.419	2022-08-11 21:57:31.28	0bfc0f51-e082-4dc9-b545-ae0afedbd330	https://loremflickr.com/640/480/fashion
BEAUTY_AND_HEALTH_CATEGORY_NAME	2022-05-12 12:12:37.81	2022-08-11 11:11:52.295	8556c563-4b04-43cb-8fe1-5bc53b5f0aad	https://loremflickr.com/640/480/fashion
CHILDRENS_GOODS_CATEGORY_NAME	2021-11-23 22:47:22.01	2022-08-12 07:43:08.195	948feb22-e480-4e24-a90d-e49aa3d990c2	https://loremflickr.com/640/480/fashion
PET_PRODUCTS_CATEGORY_NAME	2021-11-28 22:35:10.903	2022-08-12 04:36:49.114	54fa7b5f-58d1-4e5d-b588-d9a8507fa3c7	https://loremflickr.com/640/480/fashion
OFFICE_SCHOOL_BOOKS_CATEGORY_NAME	2021-12-29 15:12:09.18	2022-08-11 11:24:29.698	410c606f-f463-42ec-988e-d95917dd2834	https://loremflickr.com/640/480/fashion
ALCOHOLIC_BEVERAGES_AND_PRODUCTS_CATEGORY_NAME	2022-07-03 06:09:46.812	2022-08-12 07:57:50.652	7062243f-f114-4b5a-abea-64fc21f4e117	https://loremflickr.com/640/480/fashion
SERVICES_CATEGORY_NAME	2022-02-16 13:41:23.515	2022-08-11 11:42:21.77	f5750398-bdfa-4262-adbb-c1e1c4cc92eb	https://loremflickr.com/640/480/fashion
\.


--
-- TOC entry 3810 (class 0 OID 20040)
-- Dependencies: 223
-- Data for Name: Chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Chat" (title, "createdAt", "updatedAt", "deletedAt", id, "productId") FROM stdin;
Tuna	2022-03-07 03:28:19.433	2022-08-11 09:27:51.108	\N	73c1f55f-f3f6-4493-a40f-7beabe539207	e2a5725e-1f06-4e9b-8fee-20b19e7b59e9
Towels	2022-05-05 20:22:33.658	2022-08-11 18:58:13.521	\N	450bfda5-db0a-4496-b049-2f91c4e850ad	a620ba08-3d3e-4645-8821-cf791cc273d1
Bacon	2022-06-12 07:57:40.578	2022-08-11 19:47:20.844	\N	70ef5aa4-a0ce-41f3-9aca-b572f5f1bb7a	d2a6980a-e8bd-4512-9008-cead4dd36051
Fish	2022-04-19 15:47:43.369	2022-08-12 03:55:10.751	\N	6d3c395f-52be-4d5c-9508-46fa41a21b06	c8688a84-af18-4dfe-8f5a-b7a4396001de
Car	2021-09-28 21:54:09.372	2022-08-12 03:19:14.189	\N	11369bb1-63d4-422a-af94-026ee96bc4e5	777783f4-7547-465e-9f18-3f68e4e97ad7
Sausages	2022-02-28 19:10:35.909	2022-08-11 08:35:27.339	\N	018939ca-9eb0-4087-97f2-d54d9a82ebf3	896d7916-9e8b-47ca-9819-376d97f70145
Pizza	2022-04-11 04:36:28.761	2022-08-11 19:55:10.883	\N	50a63420-a5c4-4a58-8d01-e84f1b4fd292	7f15800b-63a1-4675-87eb-f47c38c3392a
Car	2021-10-21 03:02:46.731	2022-08-11 09:56:52.436	\N	2f48f448-d2b9-42a8-af13-e3487c0d8a59	8bb4b345-be26-4a11-ae1e-5578c2560bde
Towels	2022-02-01 07:02:12.466	2022-08-11 21:23:23.032	\N	1f9b8ddc-8a9e-4aec-b33a-cdb031a41faa	ce6b2fe9-0c66-4673-a58e-c1e76644da55
Computer	2022-07-20 23:18:11.766	2022-08-11 08:32:45.535	\N	1340cfc2-716d-4352-86f8-4897a690e477	0b8eb3c1-c769-40f3-82e2-b07d95df1cde
Car	2022-01-30 17:02:03.099	2022-08-11 14:53:08.811	\N	d039b781-b182-43aa-9bc6-90eee35dc205	f8eb7919-6ff9-42c9-8fa9-a24f5fcb1b47
Hat	2022-06-24 18:27:37.817	2022-08-12 07:39:11.888	\N	365f0aa4-4245-4c34-aeb9-535cb1125ac4	95594909-8ccd-42b6-88a1-9004b52154dd
Fish	2022-05-21 09:00:42.617	2022-08-11 08:41:34.793	\N	9e56787b-2d93-434b-8483-a756959881d2	60ed606c-6776-49cd-9da8-265e63d6e531
Cheese	2022-01-20 07:21:35.935	2022-08-11 11:18:18.099	\N	67bbe9e2-34ca-48c4-bfce-6fa1e5b876fc	4cf5f99a-43a2-476e-b31c-1b97af6d5641
Towels	2022-06-15 08:16:26.131	2022-08-11 11:22:52.186	\N	9e816253-0f24-4c32-bafd-3b080c16e191	34c563d6-7b30-4520-ac3e-0a976efc494d
Bike	2022-06-03 11:07:02.954	2022-08-12 01:46:42.602	\N	978973db-7f00-4301-ba92-25be1206906f	16024a2e-9eb4-4c20-a030-a77268fc932e
Gloves	2022-05-15 04:12:10.098	2022-08-11 12:01:52.475	\N	78956b29-ee0d-4f2f-8ab2-530fe0ee6a6d	78f23209-99fd-4e14-9e74-ac07fa405927
Keyboard	2022-04-01 06:17:14.487	2022-08-12 08:05:46.085	\N	5ecf7574-468c-4dba-9f15-3b985157ad45	ac3c4c39-f722-482f-a0d0-446070da53b0
Pants	2021-09-11 06:49:39.647	2022-08-11 12:32:58.899	\N	16e27a5b-e0aa-4412-b6ee-570202d0e187	f8822ed1-e19b-4a3a-8708-38487bbd3ff4
Chicken	2022-04-11 18:25:46.215	2022-08-11 19:52:05.264	\N	422ceea9-0ec0-4a2c-be4f-b921a0a68ecd	d65ca5be-f818-4e9a-a7d6-4944a42c29ef
Table	2021-10-26 16:34:20.548	2022-08-12 08:21:12.565	\N	96f0b956-c3e1-450e-89c1-5e61a06546e3	1e977e13-6c2a-4221-b405-7cdd7b924cd8
Computer	2021-09-03 06:03:52.621	2022-08-11 08:47:41.683	\N	aaa1da1e-c1a2-4266-a8f5-84ea289d396c	9ac78fc5-636b-4371-8fea-5a9adf7751dc
Towels	2021-08-30 03:13:02.567	2022-08-11 15:10:17.612	\N	d016e7c8-8a55-450f-8ffe-10cb01fcd211	cbc0f0fb-0699-4b71-98a7-3a9cffb18ef6
Chicken	2021-08-22 16:00:11.8	2022-08-11 17:20:04.988	\N	1c601980-dcbd-4c14-854d-7a1de55932b3	a759f3d2-fe5d-4d01-9dcf-92233538fa7a
Chips	2022-07-01 14:24:43.263	2022-08-11 19:48:47.889	\N	961d73af-c378-4a1c-8ff7-5e2af841ab73	9e26928f-7a92-4a67-a33c-4e40d1c551f4
Tuna	2022-01-20 05:36:56.685	2022-08-11 13:50:06.527	\N	b36e431e-51b5-4022-a648-ecd6616c9adb	24d1db90-9ac9-413f-854b-5b98dc220c38
Soap	2021-08-27 16:02:41.953	2022-08-11 16:13:48.18	\N	608903a0-a552-4b09-8be4-a3748273b34e	58dddeb4-3814-4c34-87a4-07854391e643
Table	2021-12-02 05:04:14.866	2022-08-11 10:50:57.997	\N	f1bc76aa-5e2e-40e5-bae2-3ffc9a3b0ff1	1cc0b14c-3499-416c-99cc-8acc4b33f141
Cheese	2021-10-14 23:09:48.236	2022-08-11 10:31:12.606	\N	3b47bba6-186b-4fd4-8d35-5bad33d4d00d	94f3dc3c-0024-456b-bef7-4951ceadbb7c
Chips	2022-08-01 05:13:59.989	2022-08-12 06:59:42.045	\N	8c5a0e80-aede-43b2-850a-62dd945399a1	acebe7ce-fdd1-43e3-b809-60d5529007a1
Keyboard	2022-02-21 11:29:48.832	2022-08-12 07:06:39.912	\N	7ba79d5f-efe0-4483-9343-4619ca9ac644	b1c5fe54-e4f6-41da-830d-a8405eb3afed
Table	2021-08-26 05:17:36.224	2022-08-11 12:44:19.42	\N	00eb1b89-1a8b-45e8-b082-57ff0ac4af07	293b7dbc-e5ba-4fa1-aea8-ed0eb07bbc64
Shirt	2021-10-29 20:56:05.146	2022-08-11 11:16:44.609	\N	5fa10647-0847-4053-8844-757fed5f1ca4	a918c110-cf4c-49fa-8b88-87ce9d514437
Cheese	2022-05-20 13:38:28.974	2022-08-11 15:38:52.984	\N	8a7687ae-19e0-42a7-9bda-f79bb12b2d3e	6120fab1-13a5-45e6-a940-af23d3d550dc
Bike	2022-06-10 20:28:41.63	2022-08-11 23:11:02.813	\N	572423ea-c3c0-4d31-bc2c-e554e4bd9916	c3459997-f038-452f-9a41-c695995265f4
Table	2022-05-07 04:53:31.333	2022-08-12 00:01:23	\N	354d4cd8-bf5e-4cf4-87e7-912649da0e8f	421049df-ae15-409e-bd8e-5da46a2094bd
Towels	2022-08-01 08:42:55.472	2022-08-12 06:52:20.373	\N	33d20e65-67ff-4911-a09f-16ce61194ddd	b04aa9bc-6528-41bb-ab14-57f51857e93b
Shirt	2022-06-30 13:59:24.407	2022-08-11 08:51:00.606	\N	a218f5a8-05d2-41a1-8ac7-12361a292536	6cd18c8f-b0c9-468c-94bf-0f7ef8d05e41
Chair	2022-01-20 14:29:27.661	2022-08-12 06:13:34.614	\N	673020ce-7177-47f7-9a63-44965f88cd6e	00ce73a7-5a71-4e2c-9098-d619043363b9
Gloves	2022-02-26 08:28:09.325	2022-08-11 10:22:41.942	\N	f33942e3-f160-4406-adae-7cd5546ff991	6360195f-7fca-49f3-af5f-7c6d06bc8994
Fish	2022-06-08 16:51:21.921	2022-08-12 04:30:40.268	\N	0fbbc285-bf39-4486-b3c8-dd3c31ac2337	431761ae-b14f-45b8-a14d-38f794e5a357
Shirt	2022-01-19 07:22:46.997	2022-08-11 20:34:53.535	\N	a33de67b-dfd0-416c-a290-681ff198007a	764069f6-75db-4560-9a4b-15e942bbf59a
Keyboard	2022-04-10 23:31:12.126	2022-08-11 18:53:30.868	\N	bb39ea81-9724-4067-9406-0f8d52bcbfff	597c8780-1381-4bd2-bc00-7376d592e5dc
Hat	2022-02-26 21:06:07.203	2022-08-12 05:36:54.828	\N	2f82693e-7a4e-4d75-ac14-0eaf22b8a24d	16b76162-757f-4e63-85ca-a3e940c217a8
Chips	2022-07-04 08:03:54.563	2022-08-12 00:39:17.869	\N	f2edc238-0d78-4e47-87eb-d8fc44b5b4be	ddc7ec64-61c9-4999-a10d-8e689a7311b2
Computer	2021-11-25 03:09:12.361	2022-08-12 04:56:34.237	\N	05efb58c-9067-47f1-8b62-f055438d6562	6d804764-11e4-48bb-93b5-fd3f48fbfd2e
Shirt	2022-03-05 02:50:29.759	2022-08-11 11:29:27.704	\N	8ddb2f00-f5f0-4a8a-8a34-9200512baa3e	ed47637a-3d78-4a28-ba02-387d15d8cecf
Cheese	2022-06-26 11:41:58.824	2022-08-12 07:49:47.883	\N	82c512cf-c0c8-4f78-a2e3-015ce5bdfb75	11e9dda4-bd1c-4f47-b1cc-30c805666ed9
\.


--
-- TOC entry 3811 (class 0 OID 20049)
-- Dependencies: 224
-- Data for Name: ChatMember; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ChatMember" ("createdAt", "updatedAt", id, "userId", "chatId") FROM stdin;
2022-04-15 19:37:17.586	2022-08-11 20:15:06.236	d64ecf0f-913b-4705-a070-a72fc629a299	807f73fb-31b8-4e66-9f74-babc8ee95d94	73c1f55f-f3f6-4493-a40f-7beabe539207
2021-12-30 07:45:27.433	2022-08-11 12:40:15.3	84805403-1655-4303-af30-d0874404fde9	b8f594a9-e836-4e25-9979-a56500b21be2	450bfda5-db0a-4496-b049-2f91c4e850ad
2021-10-10 02:38:32.067	2022-08-11 14:40:36.958	9302ff91-82a8-45f1-8127-233087acf3b9	f5cf90f8-6943-4e42-b006-03cf9bb707a4	70ef5aa4-a0ce-41f3-9aca-b572f5f1bb7a
2021-12-06 14:18:19.897	2022-08-11 20:08:25.472	5a8395b6-14d1-4f30-896b-c7d2aec1dad5	47504cdd-55e6-4584-9539-6eef69c6deed	6d3c395f-52be-4d5c-9508-46fa41a21b06
2021-10-06 01:33:44.8	2022-08-12 00:39:42.925	7d8af51c-9e5f-4c36-838a-f68a2600998d	79946740-1328-414f-bef0-926cb4eb59be	11369bb1-63d4-422a-af94-026ee96bc4e5
2022-01-14 23:53:26.752	2022-08-12 02:10:49.561	c3c15201-a89a-438e-8e14-35fc20da4f7a	807f73fb-31b8-4e66-9f74-babc8ee95d94	018939ca-9eb0-4087-97f2-d54d9a82ebf3
2022-01-31 12:33:34.146	2022-08-12 07:13:37.587	48c31dc1-184c-4db3-9993-0acc2f774e0d	b8f594a9-e836-4e25-9979-a56500b21be2	50a63420-a5c4-4a58-8d01-e84f1b4fd292
2021-08-21 15:17:32.02	2022-08-11 18:39:06.2	ff875128-5b88-4af9-a5ce-e1b6ead8c9c6	f5cf90f8-6943-4e42-b006-03cf9bb707a4	2f48f448-d2b9-42a8-af13-e3487c0d8a59
2022-04-01 11:37:54.076	2022-08-11 18:38:29.324	e19dc53e-6136-4f35-9733-ef99871d63a8	47504cdd-55e6-4584-9539-6eef69c6deed	1f9b8ddc-8a9e-4aec-b33a-cdb031a41faa
2022-04-03 04:58:47.291	2022-08-11 13:25:39.178	ac8325a6-7e05-4396-a872-e43b1670345b	79946740-1328-414f-bef0-926cb4eb59be	1340cfc2-716d-4352-86f8-4897a690e477
\.


--
-- TOC entry 3815 (class 0 OID 20288)
-- Dependencies: 228
-- Data for Name: FavoriteProducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FavoriteProducts" ("userId", "productId") FROM stdin;
\.


--
-- TOC entry 3812 (class 0 OID 20057)
-- Dependencies: 225
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Message" (text, "createdAt", "updatedAt", id, "senderId", "chatId") FROM stdin;
Facere deleniti qui pariatur.	2022-01-24 16:24:59.413	2022-08-11 10:54:33.986	429875fe-c579-4a50-a3f1-8878c4754675	807f73fb-31b8-4e66-9f74-babc8ee95d94	73c1f55f-f3f6-4493-a40f-7beabe539207
Qui architecto praesentium sint veritatis voluptatem voluptatem necessitatibus.	2022-03-21 06:02:14.937	2022-08-11 20:38:27.189	d297bf01-ea8a-40e6-8da9-5de5a1812a03	b8f594a9-e836-4e25-9979-a56500b21be2	450bfda5-db0a-4496-b049-2f91c4e850ad
Libero assumenda ut magnam facere.	2022-02-03 17:49:10.391	2022-08-11 08:56:33.045	33286dbb-e09a-4948-926c-87b40eafedf0	f5cf90f8-6943-4e42-b006-03cf9bb707a4	70ef5aa4-a0ce-41f3-9aca-b572f5f1bb7a
Adipisci iure non porro aut et voluptatem.	2021-10-19 14:02:07.429	2022-08-11 11:20:30.256	5290984f-f773-484d-bf1c-6d9c3f379a54	47504cdd-55e6-4584-9539-6eef69c6deed	6d3c395f-52be-4d5c-9508-46fa41a21b06
Perspiciatis totam enim velit facilis et omnis et alias nobis.	2022-04-21 22:01:28.126	2022-08-11 19:01:39.8	c347afd8-3b73-4790-b108-7348908f3ed1	79946740-1328-414f-bef0-926cb4eb59be	11369bb1-63d4-422a-af94-026ee96bc4e5
Labore et debitis reprehenderit repellendus aut velit unde temporibus animi.	2021-10-04 02:58:26.873	2022-08-11 16:47:05.304	6f9e6e9d-91ef-4073-a4fd-4c6ca7bdf2ec	807f73fb-31b8-4e66-9f74-babc8ee95d94	018939ca-9eb0-4087-97f2-d54d9a82ebf3
Facere facilis iste libero eius.	2022-03-29 10:57:47.081	2022-08-11 15:28:16.735	60f107b5-ada6-450f-82d2-3cf90ebdec3d	b8f594a9-e836-4e25-9979-a56500b21be2	50a63420-a5c4-4a58-8d01-e84f1b4fd292
Sequi occaecati necessitatibus omnis cupiditate qui excepturi explicabo.	2022-05-25 17:25:15.248	2022-08-11 12:34:30.441	31d8354a-977a-4447-891b-70163fbc78fb	f5cf90f8-6943-4e42-b006-03cf9bb707a4	2f48f448-d2b9-42a8-af13-e3487c0d8a59
Est dolorum qui aut.	2021-09-21 17:41:04.763	2022-08-11 12:01:06.885	ed8fc598-b3da-4a5a-af50-59fac6d6eecb	47504cdd-55e6-4584-9539-6eef69c6deed	1f9b8ddc-8a9e-4aec-b33a-cdb031a41faa
Sint assumenda ut in suscipit quia quos suscipit mollitia.	2022-07-19 17:38:11.588	2022-08-11 09:38:14.772	efa2eac4-e977-4e4e-bfe8-7a381010715a	79946740-1328-414f-bef0-926cb4eb59be	1340cfc2-716d-4352-86f8-4897a690e477
Doloribus odit autem.	2022-06-06 08:56:45.866	2022-08-11 22:01:52.376	0858e21d-e021-4e05-8d09-cc516fc6f902	807f73fb-31b8-4e66-9f74-babc8ee95d94	d039b781-b182-43aa-9bc6-90eee35dc205
Fugit et sunt nulla alias ut sed exercitationem commodi nostrum.	2022-02-28 03:50:07.456	2022-08-11 18:15:46.164	33e5ed3c-765b-4600-baf4-a63c15409f65	b8f594a9-e836-4e25-9979-a56500b21be2	365f0aa4-4245-4c34-aeb9-535cb1125ac4
Autem qui qui omnis.	2022-02-11 23:08:44.378	2022-08-12 07:36:47.212	dc0f5bc4-da7b-4a00-ac09-0d5a577934b8	f5cf90f8-6943-4e42-b006-03cf9bb707a4	9e56787b-2d93-434b-8483-a756959881d2
Id est ratione velit aut est et quo.	2022-05-19 20:23:06.249	2022-08-11 22:50:50.828	e61f8a6c-5ae2-4dcf-8973-35ea8869c451	47504cdd-55e6-4584-9539-6eef69c6deed	67bbe9e2-34ca-48c4-bfce-6fa1e5b876fc
Nobis suscipit possimus sunt deleniti error officia nemo architecto.	2022-02-24 06:08:28.457	2022-08-12 04:29:34.578	766a560b-e232-4782-9cac-41076f46304e	79946740-1328-414f-bef0-926cb4eb59be	9e816253-0f24-4c32-bafd-3b080c16e191
Magni ea beatae autem.	2022-02-13 13:11:58.381	2022-08-12 04:07:27.398	62c853a0-335a-4e6f-a6d7-375d74f5563f	807f73fb-31b8-4e66-9f74-babc8ee95d94	978973db-7f00-4301-ba92-25be1206906f
Voluptates eligendi quasi nobis illo occaecati similique ipsum.	2021-09-26 22:03:50.664	2022-08-11 23:34:02.002	c6858a46-f11a-4680-b7ad-066c483bd85a	b8f594a9-e836-4e25-9979-a56500b21be2	78956b29-ee0d-4f2f-8ab2-530fe0ee6a6d
Ea omnis aut perspiciatis rem ullam asperiores sunt totam.	2021-09-17 16:33:04.373	2022-08-11 22:12:05.613	a9f31cce-f904-4ae4-be28-1ac564059955	f5cf90f8-6943-4e42-b006-03cf9bb707a4	5ecf7574-468c-4dba-9f15-3b985157ad45
Non et numquam.	2022-06-02 04:10:14.316	2022-08-11 13:14:18.769	5dd65229-ff84-45cc-8077-b2d16551e1f2	47504cdd-55e6-4584-9539-6eef69c6deed	16e27a5b-e0aa-4412-b6ee-570202d0e187
Magni eos voluptatum sed eos officia vitae nesciunt facilis vitae.	2022-01-28 13:23:16.729	2022-08-11 18:03:09.819	46bc7bc6-49af-46b3-aa7a-6b537ac0dd4c	79946740-1328-414f-bef0-926cb4eb59be	422ceea9-0ec0-4a2c-be4f-b921a0a68ecd
Ut sequi nihil natus exercitationem omnis quam.	2022-05-05 04:23:46.84	2022-08-12 07:37:37.097	05904079-81d8-476f-9c7b-d5c73090b5ad	807f73fb-31b8-4e66-9f74-babc8ee95d94	96f0b956-c3e1-450e-89c1-5e61a06546e3
Mollitia molestiae et sapiente nesciunt.	2022-02-17 15:12:08.151	2022-08-11 12:16:20.319	5332c276-3bc0-40a8-8dca-a94fe773d96b	b8f594a9-e836-4e25-9979-a56500b21be2	aaa1da1e-c1a2-4266-a8f5-84ea289d396c
Aspernatur quidem ab totam et non.	2021-10-08 00:36:22.248	2022-08-12 07:24:23.06	cd57292d-10f1-4997-9604-7bd2eb5162b2	f5cf90f8-6943-4e42-b006-03cf9bb707a4	d016e7c8-8a55-450f-8ffe-10cb01fcd211
Soluta et autem et facere nihil sed perspiciatis.	2021-12-01 13:43:04.749	2022-08-12 04:09:19.076	87e5689c-9e19-4417-ae6c-7b672c3aec8a	47504cdd-55e6-4584-9539-6eef69c6deed	1c601980-dcbd-4c14-854d-7a1de55932b3
Ullam perferendis ipsam possimus.	2022-06-07 15:05:35.437	2022-08-12 00:56:30.899	c4906e7a-648b-4cc0-a67e-05a71e0e9234	79946740-1328-414f-bef0-926cb4eb59be	961d73af-c378-4a1c-8ff7-5e2af841ab73
Debitis deserunt explicabo eos dolorem ut placeat laudantium pariatur.	2022-02-08 04:24:22.012	2022-08-11 19:57:29.684	df9107cc-6bb0-49c1-88fa-e631c5000fa8	807f73fb-31b8-4e66-9f74-babc8ee95d94	b36e431e-51b5-4022-a648-ecd6616c9adb
Omnis et ut voluptates molestiae explicabo.	2022-06-22 13:10:37.005	2022-08-12 00:54:14.322	fb3c34d6-40e7-4e73-afaa-54e68b2df281	b8f594a9-e836-4e25-9979-a56500b21be2	608903a0-a552-4b09-8be4-a3748273b34e
Deserunt dicta ipsa nihil.	2021-12-02 08:45:15.714	2022-08-11 19:43:59.781	65713d2f-6885-4d7e-bf5b-6c317d28c499	f5cf90f8-6943-4e42-b006-03cf9bb707a4	f1bc76aa-5e2e-40e5-bae2-3ffc9a3b0ff1
Aliquid qui totam perspiciatis fuga voluptatem consequatur ut.	2021-11-10 12:03:21.824	2022-08-11 13:16:01.216	0cd84a5d-dd1f-44c3-82b8-2ea9863ecc08	47504cdd-55e6-4584-9539-6eef69c6deed	3b47bba6-186b-4fd4-8d35-5bad33d4d00d
Est omnis ut molestiae magni cupiditate voluptatem aut.	2022-06-09 13:34:57.92	2022-08-12 05:27:12.394	074376a7-a9a0-498f-acaa-2df607095323	79946740-1328-414f-bef0-926cb4eb59be	8c5a0e80-aede-43b2-850a-62dd945399a1
\.


--
-- TOC entry 3814 (class 0 OID 20279)
-- Dependencies: 227
-- Data for Name: News; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."News" (id, title, content, description, image, "createdAt", "updatedAt") FROM stdin;
5dd91e10-1b40-4dde-81e2-7005d9b90cc8	Fugiat.	At adipisci accusamus alias minima beatae quo velit velit. Cupiditate commodi eveniet illum necessitatibus quia voluptatem ad sit at. Dolores magnam ut iure tempore quidem. Ipsa voluptatibus delectus quos nemo. Alias corporis qui sequi tenetur.	Asperiores.	https://loremflickr.com/640/480/business	2021-10-12 21:05:49.333	2022-08-17 01:51:10.893
0651ef64-4fe9-4122-89ef-1a2beb55ac0a	Numquam.	At molestiae exercitationem. Laboriosam totam inventore voluptate vitae explicabo iure cumque ut molestiae. Quia est veritatis eum explicabo tenetur ex. Doloremque et qui. Pariatur impedit nihil sed modi voluptatem aut.	Omnis.	https://loremflickr.com/640/480/business	2021-10-07 00:48:18.557	2022-08-16 20:25:13.807
378084a9-f7fb-45d9-8dd0-d0d2161cd0d8	Ut.	Corrupti sint vel dolor aut explicabo voluptatibus quia. Accusamus rerum aliquam ab magnam et iusto. Aut impedit odit. Non laudantium qui eos aliquam sint assumenda facere sunt id. Asperiores voluptatibus ipsam nobis impedit velit aut autem quasi distinctio.	Magnam.	https://loremflickr.com/640/480/business	2021-11-03 17:04:50.858	2022-08-16 11:56:43.061
30336db9-cca9-49b8-9af7-039f4cb4195a	Provident.	Explicabo saepe aut ut aperiam omnis et id. Perspiciatis aperiam et vel nisi eius distinctio maxime. Sunt nihil voluptatem repellendus omnis ut. Eos velit expedita cum numquam reiciendis et. At maiores esse autem delectus ad molestiae maxime quisquam.	Sit.	https://loremflickr.com/640/480/business	2021-12-16 04:33:18.371	2022-08-17 04:41:45.996
dcb934e7-1d62-48b1-8ed9-77d7aad8c723	Consectetur.	Quis voluptas nihil harum mollitia quia. Non blanditiis sed aspernatur voluptatum sit iure odio. Aut officiis atque.	Dolores.	https://loremflickr.com/640/480/business	2022-06-15 10:03:18.614	2022-08-17 05:42:08.282
\.


--
-- TOC entry 3817 (class 0 OID 20437)
-- Dependencies: 230
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Notification" (id, "userId", "productId", type, title, description, link, viewed, "createdAt") FROM stdin;
\.


--
-- TOC entry 3816 (class 0 OID 20313)
-- Dependencies: 229
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, "productId", "buyerId", cost, status, "createdAt", "updatedAt") FROM stdin;
e3a5725e-1f06-4e9b-8fee-20b19e7b59e9	95594909-8ccd-42b6-88a1-9004b52154dd	807f73fb-31b8-4e66-9f74-babc8ee95d94	$2,000.00	PAID	2022-08-11 20:30:49.227	2022-08-13 20:30:49.227
e4a5725e-1f06-4e9b-8fee-20b19e7b59e9	b1c5fe54-e4f6-41da-830d-a8405eb3afed	807f73fb-31b8-4e66-9f74-babc8ee95d94	$6,000.00	PAID	2022-08-12 20:30:49.227	2022-08-18 20:30:49.227
\.


--
-- TOC entry 3808 (class 0 OID 20024)
-- Dependencies: 221
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (title, description, city, type, status, "endDate", "createdAt", "updatedAt", "cancelReason", id, price, "recommendedPrice", "minimalBid", "imageLinks", "authorId", "categoryId", "winnerId", views, country, phone, "postDate", condition, "participantsNotified") FROM stdin;
Awesome Cotton Table	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	Ann Arbor	AUCTION	SOLD	2023-01-07 12:49:01.897	2022-02-03 00:15:33.418	2022-08-11 20:30:49.227	aggregate	e2a5725e-1f06-4e9b-8fee-20b19e7b59e9	$42,654.00	$14,813.00	$1,000.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	51dea135-fca2-4cc0-ab5b-a32c909f14e7	b8f594a9-e836-4e25-9979-a56500b21be2	74	Shire	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Small Granite Chair	The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients	Kozeybury	AUCTION	ACTIVE	2023-04-29 15:59:33.349	2022-01-25 06:25:26.873	2022-08-11 10:54:58.904	Fish	a620ba08-3d3e-4645-8821-cf791cc273d1	$32,370.00	$28,691.00	$259.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	50d4f365-e241-4783-8b2c-809a7d83771b	\N	5	Korea	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Unbranded Bronze Keyboard	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	South Emoryshire	AUCTION	ACTIVE	2023-02-04 07:29:31.149	2022-06-29 16:03:54.686	2022-08-11 15:00:55.325	Home	d2a6980a-e8bd-4512-9008-cead4dd36051	$75,873.00	$1,356.00	$287.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	3f9bd5c0-f9a8-4763-b020-eac58681b1cf	\N	7	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Bespoke Concrete Computer	The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J	Sunnyvale	AUCTION	ACTIVE	2022-11-05 21:09:34.697	2022-07-13 11:48:59.391	2022-08-11 11:27:53.306	Pants	c8688a84-af18-4dfe-8f5a-b7a4396001de	$89,846.00	$15,524.00	$29.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	0e86f866-2146-4a5a-970b-7a62f07144a6	\N	14	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Modern Cotton Towels	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	Alannabury	AUCTION	ACTIVE	2022-11-09 17:29:45.638	2022-06-05 10:30:08.186	2022-08-11 21:00:18.968	Analyst	777783f4-7547-465e-9f18-3f68e4e97ad7	$57,574.00	$17,169.00	$854.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	a7694c34-2325-4d0d-b344-0fe074e99862	\N	46	Germany	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Refined Frozen Gloves	Andy shoes are designed to keeping in mind durability as well as trends, the most stylish range of shoes & sandals	West Orlohaven	AUCTION	FINISHED	2023-06-12 14:51:49.348	2022-07-15 23:27:04.899	2022-08-11 20:50:55.461	bluetooth	896d7916-9e8b-47ca-9819-376d97f70145	$74,966.00	$3,833.00	$296.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	6b8df3e5-b587-413f-9943-ef3d695b97c0	b8f594a9-e836-4e25-9979-a56500b21be2	16	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Unbranded Fresh Chips	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	South Ashleeton	AUCTION	ACTIVE	2023-01-10 02:43:29.147	2022-03-20 22:58:23.101	2022-08-11 16:56:12.846	proactive	7f15800b-63a1-4675-87eb-f47c38c3392a	$66,658.00	$42,176.00	$717.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	e4bef890-791e-4c53-adfd-c455227b54ad	\N	68	Ukraine	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Electronic Rubber Chicken	The Football Is Good For Training And Recreational Purposes	Palo Alto	AUCTION	ACTIVE	2023-07-10 02:17:02.195	2022-04-03 07:22:08.976	2022-08-11 19:46:17.647	didactic	8bb4b345-be26-4a11-ae1e-5578c2560bde	$76,209.00	$27,705.00	$358.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	beff46f0-133b-4af7-8206-83419b526734	\N	36	Italy	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Awesome Steel Chicken	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	Heathcotemouth	AUCTION	ACTIVE	2023-06-01 19:17:00.307	2021-10-08 05:49:10.335	2022-08-12 05:57:28.916	Handmade	ce6b2fe9-0c66-4673-a58e-c1e76644da55	$85,637.00	$26,780.00	$381.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	a351b320-76d7-4545-bb74-8bb1f2fa486d	\N	34	Spain	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Incredible Bronze Car	The Football Is Good For Training And Recreational Purposes	Port Staceyhaven	AUCTION	ACTIVE	2023-01-15 05:45:01.586	2021-08-23 10:12:50.754	2022-08-11 20:36:46.717	parse	0b8eb3c1-c769-40f3-82e2-b07d95df1cde	$56,141.00	$18,386.00	$320.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	0bfc0f51-e082-4dc9-b545-ae0afedbd330	\N	46	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Modern Steel Cheese	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	Fort Albertha	AUCTION	ACTIVE	2023-06-21 09:38:04.244	2021-09-22 17:50:30.141	2022-08-11 23:50:55.208	Interactions	f8eb7919-6ff9-42c9-8fa9-a24f5fcb1b47	$99,189.00	$3,464.00	$151.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	8556c563-4b04-43cb-8fe1-5bc53b5f0aad	\N	68	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Modern Granite Chips	Andy shoes are designed to keeping in mind durability as well as trends, the most stylish range of shoes & sandals	Smithshire	AUCTION	SOLD	2022-12-19 13:17:57.488	2021-10-13 11:54:57.191	2022-08-12 04:05:01.157	XML	95594909-8ccd-42b6-88a1-9004b52154dd	$16,129.00	$41,964.00	$92.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	948feb22-e480-4e24-a90d-e49aa3d990c2	807f73fb-31b8-4e66-9f74-babc8ee95d94	45	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Tasty Plastic Table	The Football Is Good For Training And Recreational Purposes	North Myrl	AUCTION	DRAFT	2023-05-09 15:03:40.344	2021-09-23 11:03:48.883	2022-08-12 08:23:55.336	Baby	60ed606c-6776-49cd-9da8-265e63d6e531	$48,168.00	$27,449.00	$820.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	54fa7b5f-58d1-4e5d-b588-d9a8507fa3c7	\N	24	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Practical Granite Chicken	Carbonite web goalkeeper gloves are ergonomically designed to give easy fit	Grantstead	AUCTION	ACTIVE	2022-08-13 03:54:17.092	2022-02-10 11:33:14.109	2022-08-11 15:26:01.033	circuit	4cf5f99a-43a2-476e-b31c-1b97af6d5641	$57,939.00	$41,622.00	$899.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	410c606f-f463-42ec-988e-d95917dd2834	\N	46	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Refined Cotton Car	Ergonomic executive chair upholstered in bonded black leather and PVC padded seat and back for all-day comfort and support	North Koby	AUCTION	ACTIVE	2023-01-09 04:59:25.385	2021-11-03 22:12:51.798	2022-08-11 19:11:39.126	synthesizing	34c563d6-7b30-4520-ac3e-0a976efc494d	$17,568.00	$14,006.00	$153.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	7062243f-f114-4b5a-abea-64fc21f4e117	\N	34	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Bespoke Plastic Gloves	The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients	Crystalstead	SELLING	CANCELLED	2022-12-04 23:33:30.789	2022-04-30 05:28:55.395	2022-08-11 19:33:53.558	Guatemala	16024a2e-9eb4-4c20-a030-a77268fc932e	$63,506.00	$38,158.00	$523.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	f5750398-bdfa-4262-adbb-c1e1c4cc92eb	\N	64	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Handmade Plastic Cheese	The Apollotech B340 is an affordable wireless mouse with reliable connectivity, 12 months battery life and modern design	Nedcester	AUCTION	ACTIVE	2023-03-28 07:21:11.141	2021-09-06 06:38:29.62	2022-08-12 05:26:25.359	withdrawal	78f23209-99fd-4e14-9e74-ac07fa405927	$28,956.00	$1,785.00	$670.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	51dea135-fca2-4cc0-ab5b-a32c909f14e7	\N	66	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Generic Granite Cheese	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	North Narcisoboro	AUCTION	ACTIVE	2023-03-04 14:44:03.353	2022-02-04 21:31:32.121	2022-08-12 05:59:53.185	systems	ac3c4c39-f722-482f-a0d0-446070da53b0	$81,716.00	$34,123.00	$91.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	50d4f365-e241-4783-8b2c-809a7d83771b	\N	35	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Handmade Cotton Shoes	The Football Is Good For Training And Recreational Purposes	South Jeremy	AUCTION	ACTIVE	2022-11-08 03:39:32.427	2022-03-14 03:22:09.42	2022-08-11 09:26:10.085	heuristic	f8822ed1-e19b-4a3a-8708-38487bbd3ff4	$85,771.00	$15,966.00	$441.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	3f9bd5c0-f9a8-4763-b020-eac58681b1cf	\N	51	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Handcrafted Cotton Fish	The Football Is Good For Training And Recreational Purposes	Lake Karenborough	AUCTION	ACTIVE	2023-01-06 13:00:24.923	2022-07-14 11:27:13.474	2022-08-12 03:07:18.515	transmitter	d65ca5be-f818-4e9a-a7d6-4944a42c29ef	$81,387.00	$3,180.00	$265.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	0e86f866-2146-4a5a-970b-7a62f07144a6	\N	29	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Electronic Bronze Towels	The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality	Philipburgh	AUCTION	ACTIVE	2022-12-10 06:49:47.129	2022-06-30 15:19:51.001	2022-08-11 22:09:28.489	bypassing	1e977e13-6c2a-4221-b405-7cdd7b924cd8	$40,241.00	$20,420.00	$121.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	a7694c34-2325-4d0d-b344-0fe074e99862	\N	96	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Small Concrete Salad	Carbonite web goalkeeper gloves are ergonomically designed to give easy fit	Pflugerville	AUCTION	ACTIVE	2023-06-06 02:46:39.825	2022-03-19 03:17:45.335	2022-08-11 10:38:12.111	Taka	9ac78fc5-636b-4371-8fea-5a9adf7751dc	$97,662.00	$27,649.00	$322.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	6b8df3e5-b587-413f-9943-ef3d695b97c0	\N	21	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Incredible Frozen Chair	Carbonite web goalkeeper gloves are ergonomically designed to give easy fit	South Rickey	AUCTION	ACTIVE	2022-12-20 21:53:26.335	2022-06-03 17:29:04.766	2022-08-12 05:29:51.793	Swedish	cbc0f0fb-0699-4b71-98a7-3a9cffb18ef6	$24,730.00	$6,763.00	$151.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	e4bef890-791e-4c53-adfd-c455227b54ad	\N	5	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Incredible Rubber Chicken	The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive	North Susannaport	AUCTION	ACTIVE	2022-11-06 17:22:38.539	2022-01-26 00:43:27.729	2022-08-11 18:53:43.236	invoice	a759f3d2-fe5d-4d01-9dcf-92233538fa7a	$93,801.00	$32,541.00	$372.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	beff46f0-133b-4af7-8206-83419b526734	\N	0	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Tasty Metal Cheese	The Apollotech B340 is an affordable wireless mouse with reliable connectivity, 12 months battery life and modern design	West Dixie	AUCTION	ACTIVE	2023-04-23 11:42:38.681	2022-05-30 04:26:44.364	2022-08-11 12:32:54.978	Avon	9e26928f-7a92-4a67-a33c-4e40d1c551f4	$58,967.00	$36,808.00	$689.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	a351b320-76d7-4545-bb74-8bb1f2fa486d	\N	12	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Practical Bronze Car	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	Taraberg	AUCTION	ACTIVE	2023-05-25 17:54:52.169	2021-12-03 15:38:16.633	2022-08-11 21:34:25.259	Sleek	24d1db90-9ac9-413f-854b-5b98dc220c38	$40,072.00	$20,984.00	$463.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	0bfc0f51-e082-4dc9-b545-ae0afedbd330	\N	53	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Unbranded Cotton Cheese	New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016	Malvinaville	AUCTION	ACTIVE	2023-05-25 13:39:29.845	2022-05-26 09:20:56.715	2022-08-11 18:17:57.767	Rhode	58dddeb4-3814-4c34-87a4-07854391e643	$93,311.00	$45,143.00	$706.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	8556c563-4b04-43cb-8fe1-5bc53b5f0aad	\N	85	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Oriental Frozen Pizza	The Apollotech B340 is an affordable wireless mouse with reliable connectivity, 12 months battery life and modern design	West Bernita	AUCTION	ACTIVE	2022-08-14 06:11:27.351	2021-08-15 01:59:08.588	2022-08-12 05:02:25.841	Toys	94f3dc3c-0024-456b-bef7-4951ceadbb7c	$91,427.00	$32,043.00	$603.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	54fa7b5f-58d1-4e5d-b588-d9a8507fa3c7	\N	51	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Bespoke Wooden Cheese	The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality	New Maude	AUCTION	ACTIVE	2023-06-15 19:02:03.065	2021-09-22 18:26:51.017	2022-08-12 05:08:21.846	withdrawal	acebe7ce-fdd1-43e3-b809-60d5529007a1	$46,883.00	$40,106.00	$637.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	410c606f-f463-42ec-988e-d95917dd2834	\N	12	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Generic Granite Keyboard	The Apollotech B340 is an affordable wireless mouse with reliable connectivity, 12 months battery life and modern design	Port Elwynland	AUCTION	SOLD	2022-09-22 21:57:41.419	2022-04-30 03:11:20.886	2022-08-11 09:46:52.386	lavender	b1c5fe54-e4f6-41da-830d-a8405eb3afed	$90,705.00	$21,190.00	$867.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	7062243f-f114-4b5a-abea-64fc21f4e117	807f73fb-31b8-4e66-9f74-babc8ee95d94	41	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Gorgeous Steel Bike	New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016	Paradise	AUCTION	ACTIVE	2023-01-10 03:13:32.816	2022-04-18 16:53:09.134	2022-08-11 15:12:34.266	compress	293b7dbc-e5ba-4fa1-aea8-ed0eb07bbc64	$98,693.00	$25,454.00	$978.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	f5750398-bdfa-4262-adbb-c1e1c4cc92eb	\N	53	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Licensed Cotton Pizza	The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive	Kundeport	AUCTION	ACTIVE	2023-04-11 21:15:31.618	2021-09-11 19:38:10.56	2022-08-11 12:10:04.46	purple	a918c110-cf4c-49fa-8b88-87ce9d514437	$57,266.00	$27,534.00	$680.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	51dea135-fca2-4cc0-ab5b-a32c909f14e7	\N	33	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Handmade Fresh Mouse	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	North Hiram	AUCTION	ACTIVE	2023-04-26 04:07:27.55	2022-03-02 04:29:36.581	2022-08-12 01:18:07.153	productize	6120fab1-13a5-45e6-a940-af23d3d550dc	$99,206.00	$46,096.00	$377.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	50d4f365-e241-4783-8b2c-809a7d83771b	\N	13	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Awesome Frozen Soap	The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J	Eldredside	AUCTION	ACTIVE	2022-10-03 20:11:05.469	2021-11-15 01:57:56.276	2022-08-11 22:29:16.763	Shirt	c3459997-f038-452f-9a41-c695995265f4	$77,395.00	$2,935.00	$980.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	3f9bd5c0-f9a8-4763-b020-eac58681b1cf	\N	53	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Tasty Frozen Chips	The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality	Heidenreichfurt	AUCTION	SOLD	2023-04-05 16:12:47.048	2022-05-04 04:31:39.651	2022-08-11 11:01:29.425	magnetic	421049df-ae15-409e-bd8e-5da46a2094bd	$81,852.00	$24,228.00	$330.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	0e86f866-2146-4a5a-970b-7a62f07144a6	b8f594a9-e836-4e25-9979-a56500b21be2	75	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Refined Wooden Towels	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	North Zachariah	AUCTION	DRAFT	2022-12-06 23:33:07.017	2021-10-24 07:26:41.319	2022-08-11 22:10:43.675	Investor	b04aa9bc-6528-41bb-ab14-57f51857e93b	$97,097.00	$11,616.00	$279.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	a7694c34-2325-4d0d-b344-0fe074e99862	\N	89	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Elegant Wooden Salad	The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J	Pasadena	AUCTION	ACTIVE	2023-01-24 09:36:17.647	2021-12-10 09:20:30.976	2022-08-11 14:54:36.856	envisioneer	6cd18c8f-b0c9-468c-94bf-0f7ef8d05e41	$14,270.00	$27,371.00	$513.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	6b8df3e5-b587-413f-9943-ef3d695b97c0	\N	12	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Electronic Rubber Ball	The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality	Homenickshire	AUCTION	DRAFT	2023-02-13 09:14:46.855	2022-04-06 21:31:56.813	2022-08-12 03:08:36.039	Sausages	00ce73a7-5a71-4e2c-9098-d619043363b9	$63,189.00	$23,046.00	$966.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	e4bef890-791e-4c53-adfd-c455227b54ad	\N	1	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Tasty Metal Sausages	Carbonite web goalkeeper gloves are ergonomically designed to give easy fit	Pico Rivera	AUCTION	DRAFT	2023-05-26 09:10:40.188	2022-03-17 10:38:45.757	2022-08-11 09:06:23.631	recontextualize	6360195f-7fca-49f3-af5f-7c6d06bc8994	$2,589.00	$43,087.00	$821.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	beff46f0-133b-4af7-8206-83419b526734	\N	5	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Gorgeous Concrete Table	New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016	Ashburn	AUCTION	ACTIVE	2022-10-27 07:40:18.17	2022-08-06 14:30:58.779	2022-08-11 18:27:47.395	Card	431761ae-b14f-45b8-a14d-38f794e5a357	$63,394.00	$30,581.00	$628.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	a351b320-76d7-4545-bb74-8bb1f2fa486d	\N	3	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Refined Cotton Soap	The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J	Elenaport	AUCTION	DRAFT	2023-06-26 15:43:59.951	2022-02-04 13:04:42.344	2022-08-12 03:14:30.099	analyzing	764069f6-75db-4560-9a4b-15e942bbf59a	$71,973.00	$17,661.00	$322.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	0bfc0f51-e082-4dc9-b545-ae0afedbd330	\N	8	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Small Steel Sausages	Carbonite web goalkeeper gloves are ergonomically designed to give easy fit	Chandler	AUCTION	DRAFT	2023-03-15 09:16:39.264	2022-06-27 05:06:00.263	2022-08-11 11:50:49.073	Metrics	597c8780-1381-4bd2-bc00-7376d592e5dc	$26,592.00	$44,985.00	$454.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	8556c563-4b04-43cb-8fe1-5bc53b5f0aad	\N	7	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Ergonomic Rubber Hat	New range of formal shirts are designed keeping you in mind. With fits and styling that will make you stand apart	Cletusland	AUCTION	DRAFT	2023-02-27 18:09:57.327	2022-01-30 18:36:48.051	2022-08-11 16:42:00.707	Denar	16b76162-757f-4e63-85ca-a3e940c217a8	$27,401.00	$25,216.00	$229.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	47504cdd-55e6-4584-9539-6eef69c6deed	948feb22-e480-4e24-a90d-e49aa3d990c2	\N	2	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Unbranded Wooden Bacon	The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J	Marvinworth	AUCTION	DRAFT	2023-06-08 08:50:18.413	2022-02-18 15:00:03.584	2022-08-12 06:15:12.819	Elegant	ddc7ec64-61c9-4999-a10d-8e689a7311b2	$41,818.00	$39,316.00	$459.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	79946740-1328-414f-bef0-926cb4eb59be	54fa7b5f-58d1-4e5d-b588-d9a8507fa3c7	\N	8	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Small Cotton Ball	New ABC 13 9370, 13.3, 5th Gen CoreA5-8250U, 8GB RAM, 256GB SSD, power UHD Graphics, OS 10 Home, OS Office A & J 2016	Bonita Springs	AUCTION	DRAFT	2022-12-17 07:26:47.297	2022-01-20 05:29:34.053	2022-08-11 23:00:12.901	deposit	6d804764-11e4-48bb-93b5-fd3f48fbfd2e	$95,461.00	$6,486.00	$685.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	807f73fb-31b8-4e66-9f74-babc8ee95d94	410c606f-f463-42ec-988e-d95917dd2834	\N	39	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Tasty Concrete Towels	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	New Carolanneside	AUCTION	ACTIVE	2023-02-06 10:41:15.074	2022-03-18 20:12:17.097	2022-08-11 20:21:14.25	Dollar	ed47637a-3d78-4a28-ba02-387d15d8cecf	$80,967.00	$21,743.00	$58.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	b8f594a9-e836-4e25-9979-a56500b21be2	7062243f-f114-4b5a-abea-64fc21f4e117	\N	58	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Handcrafted Soft Computer	Boston's most advanced compression wear technology increases muscle oxygenation, stabilizes active muscles	Fort Norrisside	AUCTION	DRAFT	2022-12-09 12:32:04.224	2021-09-06 05:58:55.327	2022-08-12 06:41:40.35	Investment	11e9dda4-bd1c-4f47-b1cc-30c805666ed9	$33,052.00	$6,108.00	$60.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	f5750398-bdfa-4262-adbb-c1e1c4cc92eb	\N	71	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
Recycled Concrete Towels	The slim & simple Maple Gaming Keyboard from Dev Byte comes with a sleek body and 7- Color RGB LED Back-lighting for smart functionality	South Darrellborough	AUCTION	ACTIVE	2023-04-20 13:37:10.147	2022-04-05 08:31:28.5	2023-07-15 21:45:44.442	input	1cc0b14c-3499-416c-99cc-8acc4b33f141	$56,609.00	$27,126.00	$86.00	{https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract,https://loremflickr.com/640/480/abstract}	f5cf90f8-6943-4e42-b006-03cf9bb707a4	948feb22-e480-4e24-a90d-e49aa3d990c2	\N	68	USA	+380 13 825 4164	2023-01-06 12:49:01.897	NEW	f
\.


--
-- TOC entry 3813 (class 0 OID 20263)
-- Dependencies: 226
-- Data for Name: RefreshToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RefreshToken" (id, "userId", token, "expiresAt") FROM stdin;
ab4fb3c1-1165-4b87-80fb-8dbbf65656a9	53a9aa4d-3324-400d-baf3-016749958445	b56e18dfbf893668f66e501c8c0e2871a0c35762f2d25803e6f7f7689ed6be61	2023-07-15 21:59:38
e8786cc5-326d-4941-b778-03ebdfa715e7	53a9aa4d-3324-400d-baf3-016749958445	61891486500aac704ebacde11ab53e409695a0b77a1453464d967089e17cae1d	2023-07-15 21:59:49
eafeeb0b-21f7-4ff3-92ad-e130cb256313	53a9aa4d-3324-400d-baf3-016749958445	432b002da7b05af0a71461358c22686042706d25c57a99ac2cd647da1fb5ac92	2023-07-15 22:00:36
\.


--
-- TOC entry 3806 (class 0 OID 20008)
-- Dependencies: 219
-- Data for Name: SocialMedia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SocialMedia" (link, "createdAt", "updatedAt", id, "socialMedia", "ownedByUserId", "ownedByProductId") FROM stdin;
https://watchful-cluster.info	2022-08-03 00:50:42.253	2022-08-12 00:54:50.695	edb0b888-9c70-45e1-a8f8-4c78b2246369	INSTAGRAM	807f73fb-31b8-4e66-9f74-babc8ee95d94	896d7916-9e8b-47ca-9819-376d97f70145
https://whopping-league.biz	2021-10-30 11:22:47.336	2022-08-11 19:45:20.235	a3b6ed16-af97-4b81-b75f-86fe7f254d8b	INSTAGRAM	b8f594a9-e836-4e25-9979-a56500b21be2	a620ba08-3d3e-4645-8821-cf791cc273d1
http://fickle-shadow.name	2022-04-20 11:57:32.235	2022-08-11 21:59:23.839	844b7bb6-b710-460c-8d8c-166a1e3839a4	INSTAGRAM	f5cf90f8-6943-4e42-b006-03cf9bb707a4	d2a6980a-e8bd-4512-9008-cead4dd36051
https://clear-chemotaxis.info	2022-01-31 12:50:47.43	2022-08-11 11:12:34.501	99e83863-6b2c-4897-92eb-0a58a69558dd	INSTAGRAM	47504cdd-55e6-4584-9539-6eef69c6deed	c8688a84-af18-4dfe-8f5a-b7a4396001de
http://lost-walk.biz	2022-01-20 20:24:00.198	2022-08-12 02:08:17.964	59658faa-9bbc-48f8-8169-1bba3f7a6483	INSTAGRAM	79946740-1328-414f-bef0-926cb4eb59be	777783f4-7547-465e-9f18-3f68e4e97ad7
\.


--
-- TOC entry 3803 (class 0 OID 19921)
-- Dependencies: 216
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (email, phone, "firstName", "lastName", avatar, "createdAt", role, "updatedAt", id, "passwordHash", "emailVerified", "phoneVerified") FROM stdin;
Mylene27@hotmail.com	+380 12 352 5748	Roderick	Grimes	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/374.jpg	2022-01-31 10:18:57.98	USER	2022-08-11 19:11:08.601	807f73fb-31b8-4e66-9f74-babc8ee95d94	5c6962d8a115970e390ab613b0533a7a6a8ac2e8aa8c4891d849585e8b34dfb3	t	t
Webster.Gorczany54@hotmail.com	+380 13 825 4164	Jordane	Hilpert	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/398.jpg	2022-07-01 09:30:45.046	USER	2022-08-12 06:51:14.32	b8f594a9-e836-4e25-9979-a56500b21be2	5c6962d8a115970e390ab613b0533a7a6a8ac2e8aa8c4891d849585e8b34dfb3	t	t
Leland85@gmail.com	+380 73 807 5018	Milan	Crona	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/382.jpg	2022-02-09 09:13:41.962	USER	2022-08-11 10:57:46.997	f5cf90f8-6943-4e42-b006-03cf9bb707a4	5c6962d8a115970e390ab613b0533a7a6a8ac2e8aa8c4891d849585e8b34dfb3	t	t
Aidan_Bosco@hotmail.com	+380 43 934 3101	Caroline	Rutherford	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/700.jpg	2022-05-11 14:49:23.483	USER	2022-08-11 12:04:23.026	47504cdd-55e6-4584-9539-6eef69c6deed	5c6962d8a115970e390ab613b0533a7a6a8ac2e8aa8c4891d849585e8b34dfb3	t	t
Joan67@yahoo.com	+380 08 748 7735	Pietro	Cummerata	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/247.jpg	2021-12-26 06:41:18.845	USER	2022-08-11 18:03:27.357	79946740-1328-414f-bef0-926cb4eb59be	5c6962d8a115970e390ab613b0533a7a6a8ac2e8aa8c4891d849585e8b34dfb3	t	t
ricky.yuliadi@gmail.com	+6281314332228	ricky	yuliadi	\N	2023-07-14 23:25:19.147	USER	2023-07-14 23:25:54.548	53a9aa4d-3324-400d-baf3-016749958445	bc986bb7f758825bfa75be22b20685dce9cddb1ac3c86148e9d5ec6cd6d15c34	t	t
\.


--
-- TOC entry 3804 (class 0 OID 19989)
-- Dependencies: 217
-- Data for Name: UserSettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserSettings" (language, theme, "enableEmailNotifications", "createdAt", "updatedAt", id, "userId") FROM stdin;
UA	LIGHT	t	2022-06-08 19:00:34.277	2022-08-12 06:07:14.088	b60f5e59-da16-495d-a536-e5ceeb52b452	807f73fb-31b8-4e66-9f74-babc8ee95d94
UA	LIGHT	t	2022-04-15 22:27:20.188	2022-08-12 05:40:35.56	b3e9543e-59b6-4692-87e3-06fec86dc1dc	b8f594a9-e836-4e25-9979-a56500b21be2
UA	LIGHT	t	2022-02-18 08:00:58.461	2022-08-12 03:37:17.603	19ea573f-97b1-40f7-808a-70c2e80bb3b4	f5cf90f8-6943-4e42-b006-03cf9bb707a4
UA	LIGHT	t	2022-05-25 14:42:25.974	2022-08-12 08:19:11.039	df9b2aa5-167f-42ad-88e8-04c6cb02708a	47504cdd-55e6-4584-9539-6eef69c6deed
UA	LIGHT	t	2022-06-15 06:50:36.643	2022-08-11 22:42:02.098	e3e0a9df-a733-4b06-88bc-363a2f80406d	79946740-1328-414f-bef0-926cb4eb59be
\.


--
-- TOC entry 3802 (class 0 OID 19912)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
d86c25a0-27ef-44bf-b0de-fa5aa0ab88e3	7dc4a4a158462a4fc47c89a70e2fe67b9d5952245e550815be01a58ca772507a	2023-07-16 04:40:10.843577+07	20220906200003_	\N	\N	2023-07-16 04:40:10.841099+07	1
24a1ce43-9a4f-47d2-8884-47e909322763	831d9d9b7641afe7bbda5f43ccff6d494dc18217b62a7ba36ac6ab5948093cc2	2023-07-16 04:40:10.644337+07	20220730182524_init	\N	\N	2023-07-16 04:40:10.626165+07	1
30155fac-28cd-4527-b9d0-26b3bd193d02	798ac0cbe9ca8a1acc69ee298d6d6b097969a459ffa885146ae144e031b4251a	2023-07-16 04:40:10.812147+07	20220903100211_changed_country_required	\N	\N	2023-07-16 04:40:10.809279+07	1
5c35ce7d-5046-4a12-88fc-1e0894936156	06232759c420578e04aaaa44b514d70b26bb7554da1b7a1a6b9496f63d227b27	2023-07-16 04:40:10.712097+07	20220809084851_added_db_prisma_schema	\N	\N	2023-07-16 04:40:10.645484+07	1
708e9a66-c893-4cdb-ad97-169d0030b3c5	fb92910415d08340cf03a3dd8cfc02a71c102f81bd09a346c82d6c409c049434	2023-07-16 04:40:10.760916+07	20220809113415_changed_data_types_added_rename	\N	\N	2023-07-16 04:40:10.713402+07	1
a8a2e828-beeb-4eb8-82b9-b07023997141	c9c2a97759f6fe7ae9cc3ed53475361333c9db7624407c45ac1f374fa510bade	2023-07-16 04:40:10.768037+07	20220809223300_add_refresh_token_table	\N	\N	2023-07-16 04:40:10.762034+07	1
0cb29751-cb14-42d5-b005-ee444da0eb62	34d717dc211aba9d7e3f3f3875b3f66570c32bf700f4413091b117157c4dc316	2023-07-16 04:40:10.815086+07	20220903113639_added_post_date_prop	\N	\N	2023-07-16 04:40:10.812966+07	1
987128ac-a236-4f66-b0b2-3dce147ea057	76eba9855c43b2932f230db97c7fc9593ed7e7e29d24d220892a7606c56184ce	2023-07-16 04:40:10.772308+07	20220810003716_add_password_field_to_user_table	\N	\N	2023-07-16 04:40:10.769079+07	1
a286fee6-bdef-45a4-a467-3edf4b7bb904	2339e2975d029fe7a377147182c112a2759543d7be44cd3ce02d94df2140bbe7	2023-07-16 04:40:10.778645+07	20220810083753_bugs_fixing_unique_option	\N	\N	2023-07-16 04:40:10.773244+07	1
239b897c-4b6c-42c8-957d-66d5536b3f0b	2f7f808fd780b3993b7f00aa50a419b6d580ccedefcede5f9c5ac536c4148f86	2023-07-16 04:40:10.78176+07	20220810182156_add_verification_cols_to_user_table	\N	\N	2023-07-16 04:40:10.779296+07	1
c2e2b45c-d6df-488b-9105-159a38ffe040	b7ce22a700a3986dfaaa86561e95c58e734a69efd6ef7b913233cb6941d0c2f4	2023-07-16 04:40:10.818131+07	20220903180356_delivery_data	\N	\N	2023-07-16 04:40:10.815799+07	1
d0360b51-f8af-481c-aab3-e85b8b4f2061	c0a37d507020ae1f7d6bab987f8f395f9829da47008df20d76a43d3657b4fde7	2023-07-16 04:40:10.787902+07	20220816125859_add_image_col_to_category	\N	\N	2023-07-16 04:40:10.782974+07	1
cc2e6eb2-0ee3-47f1-ac15-e852091ef573	2292b4c69554c39f62e420532cb6142c883edd20ae5cfe60a54937e7f2dccd66	2023-07-16 04:40:10.793031+07	20220817084114_add_news_table	\N	\N	2023-07-16 04:40:10.788712+07	1
c6705342-f53b-42f4-aa01-72cecb2c5589	f019a6ad8b8de4dbd5928e8c2112da96cb30931796f1afc62362ecc8a902d431	2023-07-16 04:40:10.84679+07	20220906201117_fix_bid	\N	\N	2023-07-16 04:40:10.844343+07	1
18e74f89-f36c-45bf-8cf6-f34680ff0a91	d1f4f6cd2c764bc062776ef14bf34a2b0c9d1a41adb25be1e3b9c3a2acf1ef25	2023-07-16 04:40:10.796044+07	20220824155100_add_views_field_to_product	\N	\N	2023-07-16 04:40:10.793741+07	1
a4ad1561-9d3f-46ef-8ba1-7fa901cd77f2	15e21ffbdd1b75e752e542372f55e636c5b899bacf910c917ad2a122eb95f5c3	2023-07-16 04:40:10.823779+07	20220904093312_make_product_data_nulable	\N	\N	2023-07-16 04:40:10.819246+07	1
01bb1f53-11fe-4477-aa54-fe39e5256cac	24eef03b287c97e1e74a7b3cd7842c09152c5fbcc741e878834c9d38a639dd38	2023-07-16 04:40:10.801844+07	20220828163204_add_favorite_products_table	\N	\N	2023-07-16 04:40:10.796832+07	1
9ec43cb5-8576-4551-a759-50cb45cf9423	5bd3e6b81e94e863d38a42103460cfa61a26b331241b4cddd50aa025a4b32107	2023-07-16 04:40:10.804839+07	20220831090609_last_version	\N	\N	2023-07-16 04:40:10.802714+07	1
73956f82-fdcb-4d18-ba90-733cf13ac425	3959f77f9f3bdba64c41d3519e39b4c3c9c42a2073ccb2492110099fd979b983	2023-07-16 04:40:10.808228+07	20220903095947_added_product_contacts	\N	\N	2023-07-16 04:40:10.805649+07	1
30f10f74-ca62-4e52-a888-d13a9c88bae8	d07831189029debb4d2da5785908be0eb429e68097d1165a1648876b0a7cac55	2023-07-16 04:40:10.829162+07	20220905163559_add_order_table	\N	\N	2023-07-16 04:40:10.824555+07	1
ddc2e271-dcbf-412b-8d9c-abbc35becf9f	fed9aa91576d666afcb1a5055d91aa16567ed2d541777477abddae6e7aafd6b6	2023-07-16 04:40:10.955414+07	20220915090053_notifications_add_created_at	\N	\N	2023-07-16 04:40:10.952946+07	1
6cc38479-c1a0-48a8-b0b2-afc524cc6a03	0c526cb8431f7b32e7576ec43906568aacd9595d69a7bdcc97ca43b1c07f8fba	2023-07-16 04:40:10.832238+07	20220906154705_add_condition_field	\N	\N	2023-07-16 04:40:10.829832+07	1
737482c6-b11c-4aec-a1e2-982c415cf221	acce29ef1e0a22e0fc0159cfe44e5f46c426a16948113e594b33829967efa695	2023-07-16 04:40:10.849923+07	20220907185616_add_participants_notified_to_product_table	\N	\N	2023-07-16 04:40:10.84767+07	1
828dbcf4-76c7-4e0d-9d33-9297af03a89d	9c58bf76981d8bee7ce38554ddb92489b5925f55adda8bff708c064d55773e74	2023-07-16 04:40:10.835263+07	20220906185112_add_deleted_at_to_bid	\N	\N	2023-07-16 04:40:10.832987+07	1
3eedb94b-fed9-4d10-a5ff-9f7f128475ff	8911e4213f7fc7ac4f9806638818919114453a516b42270cce57543ee42e587d	2023-07-16 04:40:10.840282+07	20220906195447_change_bid	\N	\N	2023-07-16 04:40:10.836144+07	1
d312a489-d282-4e62-b3d5-181cd8afda68	dfea58bb7d61c31be6b4cf790004f451451d10fc5db990897ee01c54f534d9f3	2023-07-16 04:40:10.940708+07	20220911220927_add_pg_trgm_extension	\N	\N	2023-07-16 04:40:10.850771+07	1
792c0542-edf1-43fd-a83e-c7c5f613d551	0a863a19bce808ab1529ec380f5ad0d3eaf48e2202fb8ca9b1a38a175b525003	2023-07-16 04:40:10.958715+07	20220915102558_notifications_add_type	\N	\N	2023-07-16 04:40:10.956198+07	1
b2487266-0d94-4883-a00c-e25b259f3490	ccc7198fa0672fc850e567f0ad6fdbbd9162e9949365a1cf3ffc837732111123	2023-07-16 04:40:10.945231+07	20220913203039_add_sold_product_status	\N	\N	2023-07-16 04:40:10.942147+07	1
7b2d8844-fb4b-4409-8596-423fc12644a2	ee127e77290cdea68d52aa816dd8d13481f1ee351b6d17215a7abf8989b764ef	2023-07-16 04:40:10.952215+07	20220914134025_add_notifications	\N	\N	2023-07-16 04:40:10.946068+07	1
789cf2fe-0205-49ef-b3d0-39052cc3b9a7	149c0b9e39c42447ff95397f030fee5cffc22b7c7ce50a572adff9c804deaa37	2023-07-16 04:40:10.965036+07	20220920184544_added_cascade_deleting	\N	\N	2023-07-16 04:40:10.959483+07	1
\.


--
-- TOC entry 3611 (class 2606 OID 20160)
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- TOC entry 3621 (class 2606 OID 20162)
-- Name: Bid Bid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bid"
    ADD CONSTRAINT "Bid_pkey" PRIMARY KEY (id);


--
-- TOC entry 3616 (class 2606 OID 20164)
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- TOC entry 3626 (class 2606 OID 20168)
-- Name: ChatMember ChatMember_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatMember"
    ADD CONSTRAINT "ChatMember_pkey" PRIMARY KEY (id);


--
-- TOC entry 3623 (class 2606 OID 20166)
-- Name: Chat Chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_pkey" PRIMARY KEY (id);


--
-- TOC entry 3634 (class 2606 OID 20292)
-- Name: FavoriteProducts FavoriteProducts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteProducts"
    ADD CONSTRAINT "FavoriteProducts_pkey" PRIMARY KEY ("userId", "productId");


--
-- TOC entry 3628 (class 2606 OID 20170)
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- TOC entry 3632 (class 2606 OID 20286)
-- Name: News News_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."News"
    ADD CONSTRAINT "News_pkey" PRIMARY KEY (id);


--
-- TOC entry 3638 (class 2606 OID 20444)
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- TOC entry 3636 (class 2606 OID 20318)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 3619 (class 2606 OID 20172)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 3630 (class 2606 OID 20269)
-- Name: RefreshToken RefreshToken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_pkey" PRIMARY KEY (id);


--
-- TOC entry 3614 (class 2606 OID 20174)
-- Name: SocialMedia SocialMedia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SocialMedia"
    ADD CONSTRAINT "SocialMedia_pkey" PRIMARY KEY (id);


--
-- TOC entry 3608 (class 2606 OID 20178)
-- Name: UserSettings UserSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSettings"
    ADD CONSTRAINT "UserSettings_pkey" PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 20176)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3602 (class 2606 OID 19920)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3612 (class 1259 OID 20179)
-- Name: Address_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Address_userId_key" ON public."Address" USING btree ("userId");


--
-- TOC entry 3617 (class 1259 OID 20275)
-- Name: Category_title_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Category_title_key" ON public."Category" USING btree (title);


--
-- TOC entry 3624 (class 1259 OID 20182)
-- Name: Chat_productId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Chat_productId_key" ON public."Chat" USING btree ("productId");


--
-- TOC entry 3609 (class 1259 OID 20192)
-- Name: UserSettings_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserSettings_userId_key" ON public."UserSettings" USING btree ("userId");


--
-- TOC entry 3603 (class 1259 OID 19977)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 3604 (class 1259 OID 19978)
-- Name: User_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_phone_key" ON public."User" USING btree (phone);


--
-- TOC entry 3640 (class 2606 OID 20198)
-- Name: Address Address_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3646 (class 2606 OID 20228)
-- Name: Bid Bid_bidderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bid"
    ADD CONSTRAINT "Bid_bidderId_fkey" FOREIGN KEY ("bidderId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3647 (class 2606 OID 20233)
-- Name: Bid Bid_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bid"
    ADD CONSTRAINT "Bid_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3649 (class 2606 OID 20462)
-- Name: ChatMember ChatMember_chatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatMember"
    ADD CONSTRAINT "ChatMember_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3650 (class 2606 OID 20243)
-- Name: ChatMember ChatMember_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ChatMember"
    ADD CONSTRAINT "ChatMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3648 (class 2606 OID 20457)
-- Name: Chat Chat_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3654 (class 2606 OID 20472)
-- Name: FavoriteProducts FavoriteProducts_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteProducts"
    ADD CONSTRAINT "FavoriteProducts_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3655 (class 2606 OID 20293)
-- Name: FavoriteProducts FavoriteProducts_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriteProducts"
    ADD CONSTRAINT "FavoriteProducts_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3651 (class 2606 OID 20467)
-- Name: Message Message_chatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3652 (class 2606 OID 20253)
-- Name: Message Message_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3658 (class 2606 OID 20450)
-- Name: Notification Notification_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3659 (class 2606 OID 20445)
-- Name: Notification Notification_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3656 (class 2606 OID 20324)
-- Name: Order Order_buyerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3657 (class 2606 OID 20319)
-- Name: Order Order_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3643 (class 2606 OID 20213)
-- Name: Product Product_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3644 (class 2606 OID 20218)
-- Name: Product Product_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3645 (class 2606 OID 20223)
-- Name: Product Product_winnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3653 (class 2606 OID 20270)
-- Name: RefreshToken RefreshToken_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3641 (class 2606 OID 20208)
-- Name: SocialMedia SocialMedia_ownedByProductId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SocialMedia"
    ADD CONSTRAINT "SocialMedia_ownedByProductId_fkey" FOREIGN KEY ("ownedByProductId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3642 (class 2606 OID 20203)
-- Name: SocialMedia SocialMedia_ownedByUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SocialMedia"
    ADD CONSTRAINT "SocialMedia_ownedByUserId_fkey" FOREIGN KEY ("ownedByUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3639 (class 2606 OID 20193)
-- Name: UserSettings UserSettings_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSettings"
    ADD CONSTRAINT "UserSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-07-16 05:13:40 WIB

--
-- PostgreSQL database dump complete
--

