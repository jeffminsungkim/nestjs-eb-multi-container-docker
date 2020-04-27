FROM node:12-alpine AS builder

WORKDIR /usr/src/app

COPY package* ./

RUN npm install --silent

COPY . .

RUN npm run build

RUN npm prune --production

FROM node:12-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules ./node_modules

EXPOSE 8000

CMD [ "node", "./dist/main" ]
