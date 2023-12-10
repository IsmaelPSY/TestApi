defmodule TestApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestApi.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, account} =
      %{
        email: "valid@gmail.com",
        hashed_password: "some hashed_password"
      }
      |> TestApi.Accounts.create_account()

    attrs =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        fullname: "backend dev"
      })

    {:ok, user} = TestApi.Users.create_user(account, attrs)

    user
  end
end
