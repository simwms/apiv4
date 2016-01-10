defmodule Apiv4.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :timezone, :string
      add :stripe_subscription_id, :string
      add :deleted_at, :datetime

      timestamps
    end

  end
end