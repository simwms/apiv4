defmodule Apiv4.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :role, :string
      add :confirmed, :boolean, default: false

      timestamps
    end

  end
end