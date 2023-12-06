defmodule TestApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def up do
    create table(:accounts) do
      add :email, :string
      add :hashed_password, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:accounts, [:email])
  end

  def down do
    drop table(:accounts)
  end
end
