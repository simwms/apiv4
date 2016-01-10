defmodule Apiv4.Repo.Migrations.CreateDeskCameras do
  use Ecto.Migration

  def change do
    create table(:desk_cameras) do
      add :filmable_id, :integer
      add :type, :string
      add :address, :string

      timestamps
    end

  end
end