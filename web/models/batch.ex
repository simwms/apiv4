defmodule Apiv4.Batch do
  use Apiv4.Web, :model

  schema "batches" do
    field :golive_at, Ecto.DateTime
    field :unlive_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    field :quantity, :string
    field :description, :string
    belongs_to :cell, Apiv4.Cell
    belongs_to :account, Apiv4.Account
    belongs_to :appointment, Apiv4.Appointment
    has_many :pictures, {"batch_pictures", Apiv4.Picture}, foreign_key: :imageable_id
    has_many :histories, {"batch_histories", Apiv4.History}, foreign_key: :recordable_id
    timestamps
  end

  @create_fields ~w(golive_at)
  @update_fields @create_fields
  @optional_fields ~w(unlive_at deleted_at quantity description cell_id account_id appointment_id)

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