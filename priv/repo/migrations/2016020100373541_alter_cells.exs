defmodule Apiv4.Repo.Migrations.AlterCells do
  use Ecto.Migration

  def change do
    alter table(:cells) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:cells, [:account_id])

  end
end