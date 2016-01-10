defmodule Apiv4.Dock do
  use Apiv4.Web, :model

  schema "docks" do
    field :status, :string
    field :a, :decimal
    field :x, :decimal
    field :y, :decimal
    field :z, :integer
    field :width, :decimal
    field :height, :decimal

    belongs_to :account, Apiv4.Account
    has_many :histories, {"dock_histories", Apiv4.History}, foreign_key: :recordable_id
    has_many :cameras, {"dock_cameras", Apiv4.Camera}, foreign_key: :filmable_id
    timestamps
  end

  @create_fields ~w(x y)
  @update_fields @create_fields
  @optional_fields ~w(status a z width height)

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