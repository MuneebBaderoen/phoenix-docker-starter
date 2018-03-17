defmodule MyappWeb.Router do
  use MyappWeb, :router

  # defp put_user_token(conn, _) do
  #   require IEx
  #   IEx.pry
  #   if current_user = String.to_integer(conn.params["user_id"]) do
  #     assign(conn, :user_id, current_user)
  #   else
  #     conn
  #   end
  # end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyappWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MyappWeb do
    pipe_through :api

    resources "/plaintexts", PlaintextController, except: [:new, :edit]
  end
end
