defmodule Apiv4.Repo.Migrations.CreateCellCameras do
  use Ecto.Migration

  def change do
    create table(:cell_cameras) do
      add :filmable_id, :integer
      add :type, :string
      add :address, :string

      timestamps
    end

  end
end