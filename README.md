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
- Fill `.env` in `packages/backend` folder
- Run `cd packages/backend && npm run db:generate && npm run db:migrate && npm run db:seed`

### Frontend 🖥

- Fill `.env` in `packages/frontend` folder

# How to start

- `npm run install:all` at the root
- Start backend `cd packages/backend && npm run start`
- Start frontend `cd packages/frontend && npm run start`

There are also other npm scripts, they are used for code style checks and linting

### Diagram

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

### Frontend

- [Next](https://nextjs.org/) - React framework
- [Emotion](https://emotion.sh/docs/introduction) - styling
- [Redux](https://redux.js.org/) - state container for JS apps
- [Redux/Toolkit](https://redux-toolkit.js.org/) - toolset for efficient Redux development

### Shared

- [Joi](https://github.com/sideway/joi) - schema description language and data validator for JS

# Documentation
<p align="center">
  <img src="https://ibb.co/G96qyyG" />
</p>
1. Sign up page
