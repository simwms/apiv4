defmodule Apiv4.Repo.Migrations.CreateServicePlans do
  use Ecto.Migration

  def change do
    create table(:service_plans) do
      add :stripe_plan_id, :string
      add :name, :string
      add :amount, :integer
      add :interval, :string
      add :interval_count, :integer
      add :currency, :string
      add :docks, :integer
      add :employees, :integer
      add :cells, :integer
      add :scales, :integer
      add :storage, :integer
      add :dataflow, :integer
      add :daily_uptime, :integer
      add :custom_domain, :boolean, default: false
      add :data_backup, :boolean, default: false
      add :description, :string
      add :presentation, :string
      add :deleted_at, :datetime

      timestamps
    end

  end
end