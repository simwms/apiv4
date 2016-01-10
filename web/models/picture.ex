defmodule Apiv4.Picture do
  use Apiv4.Web, :model

  schema "polymorphic:pictures" do
    field :imageable_id, :integer
    field :type, :string
    field :link, :string
    timestamps
  end

  @create_fields ~w(link imageable_id)
  @update_fields @create_fields
  @optional_fields ~w(type)

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