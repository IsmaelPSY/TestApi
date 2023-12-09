defmodule TestApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :decimal
      add :currency, :string
      add :description, :string
      add :type, :string
      add :status, :string
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:transactions, [:account_id])
  end
end
