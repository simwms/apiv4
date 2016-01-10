defmodule Apiv4.Repo.Migrations.AlterBatches do
  use Ecto.Migration

  def change do
    alter table(:batches) do
      add :cell_id, references(:cells, on_delete: :nothing)
      add :account_id, references(:accounts, on_delete: :nothing)
      add :appointment_id, references(:appointments, on_delete: :nothing)

      
    end
    create index(:batches, [:cell_id])
    create index(:batches, [:account_id])
    create index(:batches, [:appointment_id])

  end
end