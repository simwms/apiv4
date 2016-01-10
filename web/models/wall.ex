defmodule Apiv4.Wall do
  use Apiv4.Web, :model

  schema "walls" do
    field :points, :string
    field :x, :decimal
    field :y, :decimal
    field :a, :decimal
    field :line_name, :string

    belongs_to :account, Apiv4.Account
    timestamps 
  end

  @create_fields ~w(x y points)
  @update_fields @create_fields
  @optional_fields ~w(a line_name)

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