defmodule TestApiWeb.AccountControllerTest do
  use TestApiWeb.ConnCase

  import TestApi.AccountsFixtures

  alias TestApiWeb.Auth.Guardian
  alias TestApi.Accounts.Account

  @create_attrs %{
    email: "valid@gmail.com",
    hashed_password: "locked_password",
    full_name: "Backend Dev",
    biography: "Future great engineer"
  }
  @sign_in_attrs %{
    email: "valid@gmail.com",
    hashed_password: "some hashed_password"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # describe "index" do
  #   test "lists all accounts", %{conn: conn} do
  #     conn = get(conn, ~p"/api/accounts")
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn1 = post(conn, ~p"/api/accounts/create", account: @create_attrs)
      assert %{"id" => id, "token" => token} = json_response(conn1, 201)["data"]

      conn2 =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "valid@gmail.com"
             } = json_response(conn2, 200)["data"]
    end
  end

  describe "sign in" do
    setup [:create_account]

    test "with email and password", %{
      conn: conn,
      account: %Account{id: id, email: email} = account
    } do
      {:ok, token, _claims} = Guardian.encode_and_sign(account)

      conn =
        put_req_header(conn, "authorization", "Bearer #{token}")
        |> post(~p"/api/accounts/sign_in", @sign_in_attrs)

      assert %{"id" => ^id, "email" => ^email, "token" => _token} =
               json_response(conn, 200)["data"]
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
