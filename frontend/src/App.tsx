import { useState } from 'react'

// src/App.tsx
import { createClient } from "@connectrpc/connect";
import { createConnectTransport } from "@connectrpc/connect-web";

// 接続したいサービスをインポート
import { GreetService } from "../gen/greet/v1/greet_pb";

// transportではどのタイプのエンドポイントを使うか定義します
// 今回はConnect endpointを使います。
// エンドポイントが`g-RPC-web`しか対応していない場合は`createGrpcWebTransport`を使ってください
const transport = createConnectTransport({
    baseUrl: "http://localhost:8080"
})

// サービス定義とtransportを組み合わせてクライアントを作ります
const client = createClient(GreetService, transport)

function App() {
    const[inputValue, setInputValue] = useState("")
    return <>
        <form onSubmit={async (e) => {
            e.preventDefault(); // ページリロードを避ける
            await client.greet({
                name: inputValue
            })
        }}>
            <input value={inputValue} onChange={e =>setInputValue(e.target.value)}/>
            <button type="submit">Send</button>
        </form>
    </>
}
export default App
