defmodule Apiv4.Repo.Migrations.CreateEmployeePictures do
  use Ecto.Migration

  def change do
    create table(:employee_pictures) do
      add :imageable_id, :integer
      add :type, :string
      add :link, :string

      timestamps
    end

  end
end