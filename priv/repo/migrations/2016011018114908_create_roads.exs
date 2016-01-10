defmodule Apiv4.Repo.Migrations.CreateRoads do
  use Ecto.Migration

  def change do
    create table(:roads) do
      add :points, :string
      add :x, :decimal
      add :y, :decimal
      add :a, :decimal
      add :line_name, :string

      timestamps
    end

  end
end