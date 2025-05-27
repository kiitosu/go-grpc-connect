# ビルド環境
FROM golang:alpine3.21 AS builder

# Dockerコンテナ内の作業ディレクトリ
WORKDIR /app

# go.modとgo.sumをDockerコンテナにコピー
COPY go.mod go.sum ./

# Docker コンテナでモジュールをダウンロード
RUN go mod download

# ソースコードをDockerコンテナにコピー
COPY . .

# gRPCサーバーをビルド
RUN go build -o bin/server ./cmd/server/main.go

# gRPCサーバの実行環境
FROM alpine:latest AS server

WORKDIR /app

COPY --from=builder /app/bin/server .

EXPOSE 50051

ENTRYPOINT ["./server"]
