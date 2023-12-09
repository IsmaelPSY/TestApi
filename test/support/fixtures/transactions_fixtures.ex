defmodule TestApi.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApi.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency: "some currency",
        description: "some description",
        status: "some status",
        type: "some type"
      })
      |> TestApi.Transactions.create_transaction()

    transaction
  end
end
