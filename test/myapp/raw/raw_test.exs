defmodule Myapp.RawTest do
  use Myapp.DataCase

  alias Myapp.Raw

  describe "plaintexts" do
    alias Myapp.Raw.Plaintext

    @valid_attrs %{body: "some body", count: 42}
    @update_attrs %{body: "some updated body", count: 43}
    @invalid_attrs %{body: nil, count: nil}

    def plaintext_fixture(attrs \\ %{}) do
      {:ok, plaintext} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Raw.create_plaintext()

      plaintext
    end

    test "list_plaintexts/0 returns all plaintexts" do
      plaintext = plaintext_fixture()
      assert Raw.list_plaintexts() == [plaintext]
    end

    test "get_plaintext!/1 returns the plaintext with given id" do
      plaintext = plaintext_fixture()
      assert Raw.get_plaintext!(plaintext.id) == plaintext
    end

    test "create_plaintext/1 with valid data creates a plaintext" do
      assert {:ok, %Plaintext{} = plaintext} = Raw.create_plaintext(@valid_attrs)
      assert plaintext.body == "some body"
      assert plaintext.count == 42
    end

    test "create_plaintext/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Raw.create_plaintext(@invalid_attrs)
    end

    test "update_plaintext/2 with valid data updates the plaintext" do
      plaintext = plaintext_fixture()
      assert {:ok, plaintext} = Raw.update_plaintext(plaintext, @update_attrs)
      assert %Plaintext{} = plaintext
      assert plaintext.body == "some updated body"
      assert plaintext.count == 43
    end

    test "update_plaintext/2 with invalid data returns error changeset" do
      plaintext = plaintext_fixture()
      assert {:error, %Ecto.Changeset{}} = Raw.update_plaintext(plaintext, @invalid_attrs)
      assert plaintext == Raw.get_plaintext!(plaintext.id)
    end

    test "delete_plaintext/1 deletes the plaintext" do
      plaintext = plaintext_fixture()
      assert {:ok, %Plaintext{}} = Raw.delete_plaintext(plaintext)
      assert_raise Ecto.NoResultsError, fn -> Raw.get_plaintext!(plaintext.id) end
    end

    test "change_plaintext/1 returns a plaintext changeset" do
      plaintext = plaintext_fixture()
      assert %Ecto.Changeset{} = Raw.change_plaintext(plaintext)
    end
  end
end
