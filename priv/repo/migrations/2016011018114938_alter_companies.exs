defmodule Apiv4.Repo.Migrations.AlterCompanies do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:companies, [:account_id])

  end
end