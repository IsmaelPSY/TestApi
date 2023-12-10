defmodule TestApiWeb.TransactionControllerTest do
  use TestApiWeb.ConnCase

  import TestApi.TransactionsFixtures
  import TestApi.AccountsFixtures

  alias TestApiWeb.Auth.Guardian
  alias TestApi.Transactions.Transaction

  @create_attrs %{
    type: "some type",
    description: "some description",
    currency: "some currency",
    amount: "120.5"
  }

  setup %{conn: conn} do
    account = account_fixture(%{email: "another@gmail.com"})
    {:ok, token, _claims} = Guardian.encode_and_sign(account)

    {:ok,
     conn:
       put_req_header(conn, "accept", "application/json")
       |> put_req_header("authorization", "Bearer #{token}")}
  end

  describe "show" do
    setup [:create_transaction]

    test "get transaction by id", %{
      conn: conn,
      transaction: %Transaction{
        id: id,
        currency: currency,
        description: description,
        type: type
      }
    } do
      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "currency" => ^currency,
               "description" => ^description,
               "status" => _,
               "type" => ^type
             } = json_response(conn, 200)["data"]
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions/create", transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "120.5",
               "currency" => "some currency",
               "description" => "some description",
               "status" => "pending",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
