defmodule Apiv4.Repo.Migrations.CreateBatchPictures do
  use Ecto.Migration

  def change do
    create table(:batch_pictures) do
      add :imageable_id, :integer
      add :type, :string
      add :link, :string

      timestamps
    end

  end
end