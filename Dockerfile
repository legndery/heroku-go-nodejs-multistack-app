# build golang
FROM golang:1.14.9-alpine AS builder
RUN mkdir /build
copy go.mod go-stack/ /build/
WORKDIR /build
RUN CGO_ENABLED=0 go build

# start nginx
FROM hoosin/alpine-nginx-nodejs:latest

# copy nginx configs
COPY infrastructure/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY infrastructure/nginx/nginx.conf /etc/nginx/nginx.conf
# copy te go binary
COPY --from=builder /build/portfolio-app /root/
# build nodejs app
ENV APP_ROOT /home/app
WORKDIR $APP_ROOT
COPY .babelrc package*.json $APP_ROOT/
RUN npm install
COPY node-stack/ $APP_ROOT/node-stack/
RUN npm run build
# run all the commands
CMD /bin/sh -c "export PORT=\"${PORT:-8080}\" && \
  envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && \
  (/root/portfolio-app &) && \
  (npm start &) && \
  nginx -g 'daemon off;'"