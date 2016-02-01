defmodule Apiv4.Repo.Migrations.AlterDesks do
  use Ecto.Migration

  def change do
    alter table(:desks) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:desks, [:account_id])

  end
end