defmodule Apiv4.Report do
  use Apiv4.Web, :model

  schema "abstract:reports" do
    field :start_at, Ecto.DateTime
    field :finish_at, Ecto.DateTime
    belongs_to :account, Apiv4.Account
  end

  @create_fields ~w(start_at finish_at account_id)
  @update_fields @create_fields
  @optional_fields ~w()

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, @create_fields, @optional_fields)
  end

  def update_changeset(model, params\\:empty) do 
    create_changeset(model, params)
  end

  def delete_changeset(model, _) do
    model
  end
end