defmodule Apiv4.Repo.Migrations.AlterDocks do
  use Ecto.Migration

  def change do
    alter table(:docks) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:docks, [:account_id])

  end
end