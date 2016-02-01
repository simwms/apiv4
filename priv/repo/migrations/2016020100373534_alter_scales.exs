defmodule Apiv4.Repo.Migrations.AlterScales do
  use Ecto.Migration

  def change do
    alter table(:scales) do
      add :account_id, references(:accounts, on_delete: :nothing)

      
    end
    create index(:scales, [:account_id])

  end
end