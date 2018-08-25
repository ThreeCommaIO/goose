FROM golang:1.11rc2 as builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN GOOS=linux go build -a -ldflags '-extldflags "-static"' -o goose ./cmd/goose

FROM alpine:latest
COPY --from=builder /src/goose /go/bin/goose
ENTRYPOINT ["/go/bin/goose"]
