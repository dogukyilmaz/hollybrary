# Stage 1
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn
COPY . ./
ENV REACT_APP_ENV=prod
ENV REACT_APP_API_URL='http://0.0.0.0:8090/api'
RUN yarn build

# Stage 2
# FROM nginx:latest
FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
