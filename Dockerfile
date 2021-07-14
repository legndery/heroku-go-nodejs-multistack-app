# build golang
FROM golang:1.14.9-alpine AS builder
RUN mkdir /build
copy go.mod go-stack/ /build/
WORKDIR /build
RUN go build
RUN ls -la

FROM alpine
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/portfolio-app /app/
WORKDIR /app
CMD ["./portfolio-app"]