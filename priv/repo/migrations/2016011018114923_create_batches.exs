defmodule Apiv4.Repo.Migrations.CreateBatches do
  use Ecto.Migration

  def change do
    create table(:batches) do
      add :golive_at, :datetime
      add :unlive_at, :datetime
      add :deleted_at, :datetime
      add :quantity, :string
      add :description, :string

      timestamps
    end

  end
end