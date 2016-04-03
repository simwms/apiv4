defmodule Apiv4.Company do
  use Apiv4.Web, :model

  schema "companies" do
    field :name, :string
    field :address, :string
    field :address2, :string
    field :city, :string
    field :state, :string
    field :zipcode, :string
    field :country, :string
    field :latitude, :decimal
    field :longitude, :decimal
    belongs_to :account, Apiv4.Account
    has_many :appointments, Apiv4.Appointment
    timestamps
  end

  @create_fields ~w(name)
  @update_fields @create_fields
  @optional_fields ~w(account_id address address2 city state zipcode country latitude longitude)

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