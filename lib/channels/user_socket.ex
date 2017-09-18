defmodule Hello.UserSocket do
  use Phoenix.Socket
 
  transport :websocket, Phoenix.Transports.WebSocket
 
  channel "talks:*", Hello.TalkChannel
 
  @max_age 2 * 7 * 24 * 60 * 60
 
  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: @max_age) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _reason} ->
        :error
    end
  end
 
  def id(socket), do: "users_socket:#{socket.assigns.user_id}"