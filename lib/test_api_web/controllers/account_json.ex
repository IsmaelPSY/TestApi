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
  def show(%{account: account} = params) do
    %{data: data(account, params[:token])}
  end

  defp data(%Account{} = account, token \\ nil) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
