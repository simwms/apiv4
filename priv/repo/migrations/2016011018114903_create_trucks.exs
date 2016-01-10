defmodule Apiv4.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :golive_at, :datetime
      add :unlive_at, :datetime

      timestamps
    end

  end
end