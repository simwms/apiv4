defmodule Apiv4.Repo.Migrations.CreateDesks do
  use Ecto.Migration

  def change do
    create table(:desks) do
      add :status, :string
      add :a, :decimal
      add :x, :decimal
      add :y, :decimal
      add :z, :integer
      add :width, :decimal
      add :height, :decimal

      timestamps
    end

  end
end