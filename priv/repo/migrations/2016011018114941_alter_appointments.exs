defmodule Apiv4.Repo.Migrations.AlterAppointments do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :company_id, references(:companies, on_delete: :nothing)
      add :account_id, references(:accounts, on_delete: :nothing)
      add :employee_id, references(:employees, on_delete: :nothing)

      
    end
    create index(:appointments, [:company_id])
    create index(:appointments, [:account_id])
    create index(:appointments, [:employee_id])

  end
end