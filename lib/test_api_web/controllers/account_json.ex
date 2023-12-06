defmodule TestApiWeb.AccountJSON do
  alias TestApi.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  @doc """
  Renders a single account plus token.
  """
  def show_token(%{account: account, token: token}) do
    %{data: data_with_token(account, token)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email
    }
  end

  defp data_with_token(%Account{} = account, token) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
