defmodule TestApiWeb.TransactionController do
  use TestApiWeb, :controller

  alias TestApi.Workers
  alias TestApi.Transactions
  alias TestApi.Transactions.Transaction
  alias TestApiWeb.Auth.ErrorResponse

  action_fallback TestApiWeb.FallbackController

  def all(conn, %{"status" => status}) do

    IO.inspect(conn)
    transactions = Transactions.list_transactions(status)
    |> IO.inspect()

    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    account = conn.private[:guardian_default_resource]

    unless account.webhook do
      raise ErrorResponse.IncompleteData, message: "Webhook field missing on Account"
    end

    with {:ok, %Transaction{} = transaction} <-
           transaction_params
           |> Map.put("account_id", account.id)
           |> Transactions.create_transaction() do
      %{
        transaction_id: transaction.id
      }
      |> Workers.Transaction.new()
      |> Oban.insert()

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{transaction}")
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Transactions.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
