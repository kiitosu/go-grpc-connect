# ビルド環境
FROM golang:alpine3.21 AS builder

# Dockerコンテナ内の作業ディレクトリ
WORKDIR /app

# go.modとgo.sum、ソースコードをDockerコンテナにコピー
COPY ./backend ./
# bufで生成したインターフェースをコピー
COPY ./gen ./gen

# Docker コンテナでモジュールをダウンロード
RUN go mod download

# gRPCサーバーをビルド
RUN go build -o bin/server cmd/main.go

# gRPCサーバの実行環境
FROM alpine:latest AS server

WORKDIR /app

COPY --from=builder /app/bin/server .

EXPOSE 50051

ENTRYPOINT ["./server"]
