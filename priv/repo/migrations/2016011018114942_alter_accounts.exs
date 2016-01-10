defmodule Apiv4.Repo.Migrations.AlterAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :user_id, references(:users, on_delete: :nothing)
      add :service_plan_id, references(:service_plans, on_delete: :nothing)

      
    end
    create index(:accounts, [:user_id])
    create index(:accounts, [:service_plan_id])

  end
end