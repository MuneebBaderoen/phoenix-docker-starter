defmodule MyappWeb.PlaintextView do
  use MyappWeb, :view
  alias MyappWeb.PlaintextView

  def render("index.json", %{plaintexts: plaintexts}) do
    %{data: render_many(plaintexts, PlaintextView, "plaintext.json")}
  end

  def render("show.json", %{plaintext: plaintext}) do
    %{data: render_one(plaintext, PlaintextView, "plaintext.json")}
  end

  def render("plaintext.json", %{plaintext: plaintext}) do
    %{id: plaintext.id,
      body: plaintext.body,
      count: plaintext.count}
  end
end
