defmodule MyappWeb.UserView do
  use MyappWeb, :view

  def render("index.json", somethingElse) do
    inspect somethingElse
    %{foo: "bar"}
  end
end
