defmodule Myapp.Raw.Plaintext do
  use Ecto.Schema
  import Ecto.Changeset


  schema "plaintexts" do
    field :body, :string
    field :count, :integer

    timestamps()
  end

  @doc false
  def changeset(plaintext, attrs) do
    plaintext
    |> cast(attrs, [:body, :count])
    |> validate_required([:body, :count])
  end
end
