defmodule MyappWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", MyappWeb.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 45_000

  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    socket
    |> assign(:user_name, get_user_name(params))
    |> assign(:user_id, get_user_id(params))
    |> ok()  
  end

  defp ok(socket) do
    {:ok, socket}
  end

  defp get_user_name(params) do
    IO.inspect(params["username"])
    case params["username"] do
      nil -> "anonymous"
      id -> id
    end
  end

  defp get_user_id(params) do
    case params["user_id"] do
      nil -> 0
      id -> String.to_integer(id)
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     MyappWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
