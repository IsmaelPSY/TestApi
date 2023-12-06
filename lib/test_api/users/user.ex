defmodule TestApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fullname, :string
    field :gender, :string
    field :biography, :string
    belongs_to :account, TestApi.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :fullname, :gender, :biography])
    |> validate_required([:account_id])
  end
end
