defmodule MyappWeb.PlaintextController do
  use MyappWeb, :controller

  alias Myapp.Raw
  alias Myapp.Raw.Plaintext

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    plaintexts = Raw.list_plaintexts()
    render(conn, "index.json", plaintexts: plaintexts)
  end

  def create(conn, %{"plaintext" => plaintext_params}) do
    with {:ok, %Plaintext{} = plaintext} <- Raw.create_plaintext(plaintext_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", plaintext_path(conn, :show, plaintext))
      |> render("show.json", plaintext: plaintext)
    end
  end

  def show(conn, %{"id" => id}) do
    plaintext = Raw.get_plaintext!(id)
    render(conn, "show.json", plaintext: plaintext)
  end

  def update(conn, %{"id" => id, "plaintext" => plaintext_params}) do
    plaintext = Raw.get_plaintext!(id)

    with {:ok, %Plaintext{} = plaintext} <- Raw.update_plaintext(plaintext, plaintext_params) do
      render(conn, "show.json", plaintext: plaintext)
    end
  end

  def delete(conn, %{"id" => id}) do
    plaintext = Raw.get_plaintext!(id)
    with {:ok, %Plaintext{}} <- Raw.delete_plaintext(plaintext) do
      send_resp(conn, :no_content, "")
    end
  end
end
