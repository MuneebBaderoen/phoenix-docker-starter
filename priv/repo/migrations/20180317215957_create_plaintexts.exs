defmodule Myapp.Repo.Migrations.CreatePlaintexts do
  use Ecto.Migration

  def change do
    create table(:plaintexts) do
      add :body, :string
      add :count, :integer

      timestamps()
    end

  end
end
