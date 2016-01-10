defmodule Apiv4.Employee do
  use Apiv4.Web, :model
  alias Apiv4.User
  alias Apiv4.Repo
  schema "employees" do
    field :name, :string
    field :role, :string
    field :confirmed, :boolean, default: false
    belongs_to :account, Apiv4.Account
    belongs_to :user, Apiv4.User

    has_many :histories, {"employee_histories", Apiv4.History}, foreign_key: :recordable_id
    has_many :pictures, {"employee_pictures", Apiv4.Picture}, foreign_key: :imageable_id
    timestamps
  end

  @create_fields ~w(name)
  @update_fields @create_fields
  @optional_fields ~w(role account_id user_id confirmed)

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