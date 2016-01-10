defmodule Apiv4.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :description, :string
      add :external_reference, :string
      add :golive_at, :datetime
      add :unlive_at, :datetime
      add :deleted_at, :datetime

      timestamps
    end

  end
end