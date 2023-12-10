defmodule TestApi.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApi.Accounts.Account

  schema "transactions" do
    field :status, :string, default: "pending"
    field :type, :string
    field :description, :string
    field :currency, :string
    field :amount, :decimal
    belongs_to(:account, Account)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :currency, :description, :type, :status, :account_id])
    |> validate_required([:amount, :currency, :description, :type, :status, :account_id])
  end

  @doc false
  def create_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :currency, :description, :type, :account_id])
    |> validate_required([:amount, :currency, :description, :type, :status, :account_id])
  end

  @doc false
  def update_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
