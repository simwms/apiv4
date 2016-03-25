defmodule Apiv4.User do
  use Apiv4.Web, :model
  import Autox.User
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :recovery_hash, :string
    field :remember_token, :string
    field :stripe_customer_id, :string
    field :forget_at, Ecto.DateTime
    has_many :employees, Apiv4.Employee
    has_many :accounts, Apiv4.Account
    has_many :unconfirmed_employees, Apiv4.Employee, foreign_key: :email, references: :email
    timestamps
  end

  @creation_fields ~w(email password)
  @updative_fields ~w(password)
  @optional_fields ~w()
  @password_hash_opts [min_length: 1]

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, @creation_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: @password_hash_opts[:min_length])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> prepare_changes(&encrypt_password/1)
    |> prepare_changes(&setup_remember_token/1)
    |> initialize_stripe_customer
  end

  def update_changeset(model, params\\:empty) do
    model
    |> cast(params, @updative_fields, @optional_fields)
  end

  defp initialize_stripe_customer(%{valid?: false}=cs), do: cs
  defp initialize_stripe_customer(changeset) do
    email = changeset |> get_field(:email)
    case Stripex.Customers.create(email: email) do
      {:ok, %{id: id}} -> 
        changeset 
        |> put_change(:stripe_customer_id, id)
      {:error, _} -> 
        changeset 
        |> add_error(:stripe_customer_id, "stripe customer currently undergoing service")
    end
  end
end