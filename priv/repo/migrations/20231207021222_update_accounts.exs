defmodule TestApi.Repo.Migrations.UpdateAccounts do
  use Ecto.Migration

  def up do
    alter table :accounts do
      add :webhook, :string
    end
  end

  def down do
    remove :webhook
  end
end
