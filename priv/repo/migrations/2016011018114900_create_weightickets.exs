defmodule Apiv4.Repo.Migrations.CreateWeightickets do
  use Ecto.Migration

  def change do
    create table(:weightickets) do
      add :arrive_pounds, :decimal
      add :depart_pounds, :decimal
      add :license_plate, :string
      add :notes, :string
      add :external_reference, :string
      add :golive_at, :datetime
      add :unlive_at, :datetime

      timestamps
    end

  end
end