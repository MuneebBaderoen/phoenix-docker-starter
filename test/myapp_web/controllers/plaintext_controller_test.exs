defmodule MyappWeb.PlaintextControllerTest do
  use MyappWeb.ConnCase

  alias Myapp.Raw
  alias Myapp.Raw.Plaintext

  @create_attrs %{body: "some body", count: 42}
  @update_attrs %{body: "some updated body", count: 43}
  @invalid_attrs %{body: nil, count: nil}

  def fixture(:plaintext) do
    {:ok, plaintext} = Raw.create_plaintext(@create_attrs)
    plaintext
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all plaintexts", %{conn: conn} do
      conn = get conn, plaintext_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plaintext" do
    test "renders plaintext when data is valid", %{conn: conn} do
      conn = post conn, plaintext_path(conn, :create), plaintext: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, plaintext_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "count" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, plaintext_path(conn, :create), plaintext: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plaintext" do
    setup [:create_plaintext]

    test "renders plaintext when data is valid", %{conn: conn, plaintext: %Plaintext{id: id} = plaintext} do
      conn = put conn, plaintext_path(conn, :update, plaintext), plaintext: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, plaintext_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "count" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, plaintext: plaintext} do
      conn = put conn, plaintext_path(conn, :update, plaintext), plaintext: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plaintext" do
    setup [:create_plaintext]

    test "deletes chosen plaintext", %{conn: conn, plaintext: plaintext} do
      conn = delete conn, plaintext_path(conn, :delete, plaintext)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, plaintext_path(conn, :show, plaintext)
      end
    end
  end

  defp create_plaintext(_) do
    plaintext = fixture(:plaintext)
    {:ok, plaintext: plaintext}
  end
end
