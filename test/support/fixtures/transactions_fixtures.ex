defmodule TestApi.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApi.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, account} =
      %{
        email: "valid@gmail.com",
        hashed_password: "some hashed_password"
      }
      |> TestApi.Accounts.create_account()

    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency: "USD",
        description: "some description",
        type: "some type",
        account_id: account.id
      })
      |> TestApi.Transactions.create_transaction()

    transaction
  end
end
