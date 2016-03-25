defmodule Apiv4.Repo.Migrations.AlterRoads do
  use Ecto.Migration

  def change do
    alter table(:roads) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:roads, [:account_id])

  end
end