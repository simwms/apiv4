defmodule Apiv4.Repo.Migrations.AlterEmployees do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      
    end
    create index(:employees, [:account_id])
    create index(:employees, [:user_id])

  end
end