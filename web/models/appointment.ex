defmodule Apiv4.Appointment do
  use Apiv4.Web, :model
  alias Apiv4.AppointmentSeed
  alias Apiv4.Repo
  schema "appointments" do
    field :description, :string
    field :external_reference, :string
    field :golive_at, Ecto.DateTime
    field :unlive_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    field :company_name, :string
    belongs_to :company, Apiv4.Company
    belongs_to :account, Apiv4.Account
    belongs_to :employee, Apiv4.Employee
    has_one :weighticket, Apiv4.Weighticket
    has_one :truck, Apiv4.Truck
    has_many :in_batches, Apiv4.Batch, foreign_key: :in_appointment_id
    has_many :out_batches, Apiv4.Batch, foreign_key: :out_appointment_id
    has_many :histories, {"appointment_histories", Apiv4.History}, foreign_key: :recordable_id

    timestamps
  end

  @create_fields ~w(golive_at company_id account_id)
  @update_fields @create_fields
  @optional_fields ~w(employee_id description external_reference unlive_at deleted_at)

  def create_changeset(model, params\\:empty) do
    params = AppointmentSeed.sow(params, model)
    model
    |> cast(params, @create_fields, @optional_fields)
    |> cast_assoc(:truck, with: &Apiv4.Truck.create_changeset/2)
    |> cast_assoc(:weighticket, with: &Apiv4.Weighticket.create_changeset/2)
    |> assoc_constraint(:company)
    |> prepare_changes(&punch_company_name/1)
  end

  def update_changeset(model, params\\:empty) do 
    model
    |> cast(params, @create_fields, @optional_fields)
    |> assoc_constraint(:company)
    |> prepare_changes(&punch_company_name/1)
  end

  def delete_changeset(model, _) do
    model
  end

  defp punch_company_name(changeset) do
    changeset
    |> get_field(:company_id)
    |> case do
      nil -> nil
      id ->  Repo.get(Apiv4.Company, id)
    end
    |> case do
      nil -> changeset
      %{name: name} -> 
        changeset |> put_change(:company_name, name)
    end
  end
end