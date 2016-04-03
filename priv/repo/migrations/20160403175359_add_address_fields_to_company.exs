defmodule Apiv4.Repo.Migrations.AddAddressFieldsToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :address, :string
      add :address2, :string
      add :city, :string
      add :state, :string
      add :zipcode, :string
      add :country, :string
      add :latitude, :decimal, precision: 11, scale: 7
      add :longitude, :decimal, precision: 11, scale: 7
    end
  end
end
