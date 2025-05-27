package main
import (
    "context"
    "log"
    "net/http"

    greetv1 "example/gen/greet/v1"
    "example/gen/greet/v1/greetv1connect"
    "connectrpc.com/connect"
)

func main() {
	// Connectが作ったClientを使ってclientインスタンスを作る
    client := greetv1connect.NewGreetServiceClient(
        http.DefaultClient,
        "http://localhost:8080",
		connect.WithGRPC(),
    )
	// Greet関数呼び出し
    res, err := client.Greet(
		// ルートコンテキストで実行
        context.Background(),
		// GreetRequest型を使い、NewRequestを実行
        connect.NewRequest(&greetv1.GreetRequest{Name: "Jane"}),
    )
    if err != nil {
        log.Println(err)
        return
    }
    log.Println(res.Msg.Greeting)
}