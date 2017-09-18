defmodule Hello.TalkChannel do
  use Phoenix.Channel
 
  def join("talks:hello", msg, socket) do
    {:ok, socket}
  end