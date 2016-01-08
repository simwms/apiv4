defmodule Apiv4.History do
  use Apiv4.Web, :model

  schema "histories" do

    timestamps
  end

  @create_fields ~w()
  @update_fields @create_fields
  @optional_fields ~w()

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, @create_fields, @optional_fields)
  end

  def update_changeset(model, params\\:empty) do 
    create_changeset(model, params)
  end
end