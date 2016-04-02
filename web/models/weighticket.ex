defmodule Apiv4.Weighticket do
  use Apiv4.Web, :model

  schema "weightickets" do
    field :arrive_pounds, :decimal
    field :depart_pounds, :decimal
    field :license_plate, :string
    field :notes, :string
    field :external_reference, :string
    field :golive_at, Ecto.DateTime
    field :unlive_at, Ecto.DateTime

    belongs_to :account, Apiv4.Account
    belongs_to :appointment, Apiv4.Appointment
    
    timestamps
  end

  @create_fields ~w(account_id golive_at)
  @update_fields @create_fields
  @optional_fields ~w(arrive_pounds depart_pounds license_plate notes external_reference unlive_at appointment_id)

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