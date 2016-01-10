defmodule Apiv4.Truck do
  use Apiv4.Web, :model

  schema "trucks" do
    belongs_to :account, Apiv4.Account
    belongs_to :appointment, Apiv4.Appointment
    field :golive_at, Ecto.DateTime
    field :unlive_at, Ecto.DateTime
    has_many :histories, {"truck_histories", Apiv4.History}, foreign_key: :recordable_id
    has_many :pictures, {"truck_pictures", Apiv4.Picture}, foreign_key: :imageable_id
    timestamps
  end

  @create_fields ~w(golive_at account_id appointment_id)
  @update_fields @create_fields
  @optional_fields ~w(unlive_at)

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