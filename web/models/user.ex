defmodule Apiv4.User do
  use Apiv4.Web, :model

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
    timestamps
  end

  @creation_fields ~w(email password)
  @updative_fields ~w(password)
  @optional_fields ~w()
  @password_hash_opts [min_length: 1, extra_chars: false, common: false]

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

  defp encrypt_password(changeset) do
    {:ok, password_hash} = changeset
    |> get_field(:password)
    |> Comeonin.create_hash(@password_hash_opts)

    changeset
    |> put_change(:password_hash, password_hash)
  end

  defp setup_remember_token(changeset) do
    {:changes, email} = changeset |> fetch_field(:email)
    {:changes, hash} = changeset |> fetch_field(:password_hash)

    changeset |> remember_me_core(email, hash)
  end

  defp remember_me_core(changeset, email, password) do
    key = "#{email}-#{password}"
    {x,y,z} = :os.timestamp
    salt = "#{x}-#{y}-#{z}"
    token = :sha256 |> :crypto.hmac(key, salt) |> Base.encode64
    date = Ecto.DateTime.utc |> Map.update(:year, 3000, &(&1 + 5))
    changeset
    |> put_change(:remember_token, token)
    |> put_change(:forget_at, date)
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