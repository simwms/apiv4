defmodule Apiv4.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string

      timestamps
    end

  end
end