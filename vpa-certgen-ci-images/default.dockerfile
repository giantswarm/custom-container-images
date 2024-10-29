FROM --platform=linux/amd64 quay.io/reactiveops/ci-images:v14.1-alpine

RUN apk add --no-cache openssl
