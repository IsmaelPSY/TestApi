defmodule TestApi.Factory do
  use ExMachina.Ecto, repo: TestApi.Repo

  def user_factory do
    %TestApi.Users.User{
      biography: "some biography",
      full_name: "some fullname",
      gender: "some gender",
      account_id: 1
    }
  end

  def account_factory do
    %TestApi.Accounts.Account{
      email: "valid@gmail.com",
      hashed_password: "hashed_password"
    }
  end
end
