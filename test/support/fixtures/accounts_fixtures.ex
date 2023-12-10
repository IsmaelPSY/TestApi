defmodule TestApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApi.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "valid@gmail.com",
        hashed_password: "some hashed_password",
        webhook: "fetch_bank_url"
      })
      |> TestApi.Accounts.create_account()

    account
  end
end
