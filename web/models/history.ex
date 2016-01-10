defmodule Apiv4.History do
  use Apiv4.Web, :model

  schema "polymorphic:histories" do
    field :recordable_id, :integer
    field :permalink, :string
    field :type, :string
    field :name, :string
    field :message, :string
    field :scheduled_at, Ecto.DateTime
    field :happened_at, Ecto.DateTime

    field :mentioned_type, :string
    field :mentioned_id, :integer
    field :mentioned, :map, virtual: true
    timestamps
  end

  @create_fields ~w(type name recordable_id)
  @update_fields @create_fields
  @optional_fields ~w(message scheduled_at happened_at mentioned_id mentioned_type mentioned)

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