defmodule Apiv4.Repo.Migrations.AlterGates do
  use Ecto.Migration

  def change do
    alter table(:gates) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:gates, [:account_id])

  end
end