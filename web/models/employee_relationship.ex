defmodule Apiv4.EmployeeRelationship do
  use Apiv4.Web, :model

  schema "employee_relationships" do

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