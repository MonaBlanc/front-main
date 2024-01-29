FROM node:21 as builder

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

FROM nginx

WORKDIR /app

COPY /nginx/ /etc/nginx
COPY --from=builder /app/dist/* /usr/share/nginx/html
COPY entrypoint.sh /docker-entrypoint.d/entrypoint.sh
RUN chmod +x /docker-entrypoint.d/entrypoint.sh

