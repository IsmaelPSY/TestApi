defmodule TestApi.Accounts.Account do
  alias TestApi.Transactions.Transaction
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :email, :string
    field :hashed_password, :string
    field :webhook, :string
    has_one :user, TestApi.Users.User
    has_many :transactions, Transaction

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hashed_password, :webhook])
    |> validate_required([:email, :hashed_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hashed_password: hashed_password}} = changeset
       ) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(hashed_password))
  end

  defp put_password_hash(changeset), do: changeset
end
