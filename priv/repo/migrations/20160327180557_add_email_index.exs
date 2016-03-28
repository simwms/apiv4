defmodule Apiv4.Repo.Migrations.AddEmailIndex do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email])
    create index(:employees, [:email])
    create index(:sessions, [:email])
  end
end
