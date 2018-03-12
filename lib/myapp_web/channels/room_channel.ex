defmodule MyappWeb.RoomChannel do
  use Phoenix.Channel
  alias MyappWeb.Presence

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:seconds))
    })
    {:noreply, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  intercept ["new_msg"]

  def handle_out("new_msg", msg, socket) do
    if rem(socket.assigns[:user_id], 2) != 0 do
      {:noreply, socket}
    else
      push socket, "new_msg", msg
      {:noreply, socket}
    end
  end
end
