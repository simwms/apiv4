defmodule Apiv4.Appointment do
  use Apiv4.Web, :model

  schema "appointments" do
    field :description, :string
    field :external_reference, :string
    field :golive_at, Ecto.DateTime
    field :unlive_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    belongs_to :company, Apiv4.Company
    belongs_to :account, Apiv4.Account
    belongs_to :employee, Apiv4.Employee
    has_one :weighticket, Apiv4.Weighticket

    has_many :batches, Apiv4.Batch
    has_many :histories, {"appointment_histories", Apiv4.History}, foreign_key: :recordable_id

    timestamps
  end

  @create_fields ~w(golive_at company_id account_id)
  @update_fields @create_fields
  @optional_fields ~w(employee_id description external_reference unlive_at deleted_at)

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