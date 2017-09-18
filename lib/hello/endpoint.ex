defmodule Hello.Endpoint do
  use Phoenix.Endpoint
 
  socket "/socket", Hello.UserSocket
  ...
end