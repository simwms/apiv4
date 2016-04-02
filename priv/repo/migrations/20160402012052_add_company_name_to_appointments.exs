defmodule Apiv4.Repo.Migrations.AddCompanyNameToAppointments do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :company_name, :string
    end
  end
end
