defmodule Apiv4.Repo.Migrations.CreateDockCameras do
  use Ecto.Migration

  def change do
    create table(:dock_cameras) do
      add :filmable_id, :integer
      add :type, :string
      add :address, :string

      timestamps
    end

  end
end