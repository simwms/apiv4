defmodule Apiv4.Repo.Migrations.AddCompanyIdToTrucks do
  use Ecto.Migration

  def change do
    alter table(:trucks) do
      add :company_id, references(:companies, on_delete: :nothing)
      add :company_name, :string
    end
    create index(:trucks, [:company_id])
  end
end
