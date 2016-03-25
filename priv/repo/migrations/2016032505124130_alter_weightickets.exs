defmodule Apiv4.Repo.Migrations.AlterWeightickets do
  use Ecto.Migration

  def change do
    alter table(:weightickets) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :appointment_id, references(:appointments, on_delete: :nothing)

      
    end
    create index(:weightickets, [:account_id])
    create index(:weightickets, [:appointment_id])

  end
end