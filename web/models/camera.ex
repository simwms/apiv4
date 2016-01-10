defmodule Apiv4.Camera do
  use Apiv4.Web, :model

  schema "polymorphic:cameras" do
    field :filmable_id, :integer
    field :type, :string
    field :address, :string
    timestamps
  end

  @create_fields ~w(filmable_id)
  @update_fields @create_fields
  @optional_fields ~w(type address)

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