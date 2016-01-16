defmodule Apiv4.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :recovery_hash, :string
      add :remember_token, :string
      add :stripe_customer_id, :string
      add :forget_at, :datetime

      timestamps
    end

  end
end