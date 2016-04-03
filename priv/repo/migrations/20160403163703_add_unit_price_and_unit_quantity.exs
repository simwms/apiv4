defmodule Apiv4.Repo.Migrations.AddUnitPriceAndUnitQuantity do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :price_number, :decimal, precision: 16, scale: 8
      add :price_units, :string
      add :price_notes, :string
      add :quantity_number, :decimal, precision: 16, scale: 8
    end

    alter table(:batches) do
      add :quantity_number, :decimal, precision: 16, scale: 8
      add :quantity_units, :string
    end
  end
end
