defmodule Apiv4.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :email, :string
      add :remember_token, :string

      timestamps
    end

  end
end