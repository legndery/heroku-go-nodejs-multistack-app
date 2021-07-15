# build golang
FROM golang:1.14.9-alpine AS builder
RUN mkdir /build
copy go.mod go-stack/ /build/
WORKDIR /build
RUN go build
RUN ls -la

# start nginx
FROM nginx:1.21.0-alpine

COPY infrastructure/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY infrastructure/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /build/portfolio-app /root/
RUN ls -la /root/
CMD /bin/sh -c "export PORT=\"${PORT:-8080}\" && envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && (/root/portfolio-app &) && nginx -g 'daemon off;'"