defmodule Apiv4.Repo.Migrations.AlterWalls do
  use Ecto.Migration

  def change do
    alter table(:walls) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:walls, [:account_id])

  end
end