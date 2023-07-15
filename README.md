# Jitera Auction

As an online auction platform for Full Stack Coding Assignment in Jitera.

# Packages 📦

- [Backend](./packages/backend)
- [Frontend](./packages/frontend)
- [Shared](./packages/shared)

# Requirements:

- NodeJS (16.x.x)
- NPM (8.x.x)

**Note**: If you are using Windows, do these two additional steps **before** cloning the repo:

- Change `eol` setting in your code editor to `lf`.
- Change the `autocrlf` setting to `input` in the Git settings:

```
git config --global core.autocrlf input
```

# Before start

### Backend 💾

- Create DB using PostgreSQL
- Run pg_restore dump.sql
- Fill `.env` in `packages/backend` folder

### Frontend 🖥

- Fill `.env` in `packages/frontend` folder

# How to start

- `npm run install:all` at the root
- Start backend `cd packages/backend && npm run start`
- Start frontend `cd packages/frontend && npm run start`

There are also other npm scripts, they are used for code style checks and linting

# Diagram

<p align="center">
  <img src="https://i.ibb.co/X8sbvVt/auction-website-diagram.png" />
</p>

# DB Schema

![DB Schema](./packages/backend/prisma/ERD.svg)

# Technologies 🛠

### Backend

- [Prisma](https://www.prisma.io/) - an ORM
- [Express](https://expressjs.com/) - a node.js framework
- [PostgreSql](https://www.postgresql.org/) - for DB
- [Redis](https://redis.com) - Key store and pub sub
- [Socket.io](https://socket.io) - Bidirectional and low-latency communication


### Frontend

- [Next](https://nextjs.org/) - React framework
- [Emotion](https://emotion.sh/docs/introduction) - styling
- [Redux](https://redux.js.org/) - state container for JS apps
- [Redux/Toolkit](https://redux-toolkit.js.org/) - toolset for efficient Redux development

### Shared

- [Joi](https://github.com/sideway/joi) - schema description language and data validator for JS

# Documentation
1. Sign up page
<p align="center">
  <img src="https://i.ibb.co/zFMzppC/signup.png" alt="signup" border="0">
</p>
2. Home page can be access by everyone,but they have to login/sign up to make a bid
<p align="center">
<img src="https://i.ibb.co/9Z9Nbyz/home-page-no-login.png" alt="home-page-no-login" border="0">
</p>
3. Profile page to see profile info, list items, post items
<p align="center">
<img src="https://i.ibb.co/8Kvt2zF/edit-profile.png" alt="edit-profile" border="0">
</p>
4. Post items for auction
<p align="center">
<img src="https://i.ibb.co/52HKRnT/create-auction.png" alt="create-auction" border="0">
</p>
5. List items posted, placed bid
<p align="center">
<img src="https://i.ibb.co/JCJK7Hh/my-list.png" alt="my-list" border="0">
</p>
6. Bid items
<p align="center">
<img src="https://i.ibb.co/VV6K2dJ/bid-item.png" alt="bid-item" border="0">
</p>
