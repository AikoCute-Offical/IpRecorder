# Build go
FROM golang:latest AS builder
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
RUN go mod download && \
    go env -w GOFLAGS=-buildvcs=false && \
    go build -v -o IpRecorder -trimpath -ldflags "-s -w -buildid=" .

# Release
FROM alpine:latest 
RUN apk --update --no-cache add tzdata ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && \
    mkdir /etc/IpRecorder/
COPY --from=builder /app/IpRecorder /usr/local/bin

ENTRYPOINT [ "IpRecorder", "-path", "/etc/IpRecorder/config.json" ]