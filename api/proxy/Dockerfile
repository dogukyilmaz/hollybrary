FROM node:18-alpine as base

WORKDIR /proxy
COPY yarn.lock ./
COPY package*.json ./
RUN yarn
COPY . .
RUN yarn build
EXPOSE 4500

CMD ["npm","start"]