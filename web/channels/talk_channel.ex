defmodule Hello.TalkChannel do
  use Phoenix.Channel
 
  def join("talks:hello", msg, socket) do
    {:ok, socket}
  end
 
  # jsからは`"msg"`というイベント名で送信しているので、そのイベント名でパターンマッチ
  def handle_in("msg", params, socket) do
    user = Hello.Repo.get(Hello.User, socket.assigns.user_id)
    handle_in("msg", params, user, socket)
  end
 
  # 接続しているユーザーにメッセージをブロードキャストする
  def handle_in("msg", params, user, socket) do
    broadcast! socket, "msg", %{user: user.name, body: params["body"]}
    {:reply, {:ok, %{msg: params["body"]}}, assign(socket, :user, params["user"])}
  end
 
  # ブロードキャストする前にメッセージをカスタマイズするにはこのコールバックを使う
  # ここでは何もしない
  def handle_out("msg", payload, socket) do
    push socket, "msg", payload
    {:noreply, socket}
  end
ends