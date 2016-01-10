defmodule Apiv4.Repo.Migrations.AlterTrucks do
  use Ecto.Migration

  def change do
    alter table(:trucks) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :appointment_id, references(:appointments, on_delete: :nothing)

      
    end
    create index(:trucks, [:account_id])
    create index(:trucks, [:appointment_id])

  end
end