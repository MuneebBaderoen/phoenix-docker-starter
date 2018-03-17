defmodule Myapp.Raw do
  @moduledoc """
  The Raw context.
  """

  import Ecto.Query, warn: false
  alias Myapp.Repo

  alias Myapp.Raw.Plaintext

  @doc """
  Returns the list of plaintexts.

  ## Examples

      iex> list_plaintexts()
      [%Plaintext{}, ...]

  """
  def list_plaintexts do
    Repo.all(Plaintext)
  end

  @doc """
  Gets a single plaintext.

  Raises `Ecto.NoResultsError` if the Plaintext does not exist.

  ## Examples

      iex> get_plaintext!(123)
      %Plaintext{}

      iex> get_plaintext!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plaintext!(id), do: Repo.get!(Plaintext, id)

  @doc """
  Creates a plaintext.

  ## Examples

      iex> create_plaintext(%{field: value})
      {:ok, %Plaintext{}}

      iex> create_plaintext(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plaintext(attrs \\ %{}) do
    %Plaintext{}
    |> Plaintext.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plaintext.

  ## Examples

      iex> update_plaintext(plaintext, %{field: new_value})
      {:ok, %Plaintext{}}

      iex> update_plaintext(plaintext, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plaintext(%Plaintext{} = plaintext, attrs) do
    plaintext
    |> Plaintext.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Plaintext.

  ## Examples

      iex> delete_plaintext(plaintext)
      {:ok, %Plaintext{}}

      iex> delete_plaintext(plaintext)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plaintext(%Plaintext{} = plaintext) do
    Repo.delete(plaintext)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plaintext changes.

  ## Examples

      iex> change_plaintext(plaintext)
      %Ecto.Changeset{source: %Plaintext{}}

  """
  def change_plaintext(%Plaintext{} = plaintext) do
    Plaintext.changeset(plaintext, %{})
  end
end
