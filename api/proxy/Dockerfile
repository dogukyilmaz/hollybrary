FROM node:18-alpine as base

WORKDIR /proxy
COPY yarn.lock ./
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 4500

CMD ["npm","start"]