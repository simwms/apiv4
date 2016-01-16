defmodule Apiv4.Repo.Migrations.AlterSessions do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :account_id, references(:accounts, on_delete: :nothing)
      add :employee_id, references(:employees, on_delete: :nothing)

      
    end
    create index(:sessions, [:user_id])
    create index(:sessions, [:account_id])
    create index(:sessions, [:employee_id])

  end
end