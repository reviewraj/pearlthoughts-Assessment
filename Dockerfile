FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npx nx build pt-notification-service

FROM node:18

WORKDIR /app

COPY --from=build /app/dist/pt-notification-service /app/dist/pt-notification-service

ENV NODE_ENV=production

EXPOSE 4200

CMD ["npx", "nx", "serve", "pt-notification-service"]
