defmodule Apiv4.Session do
  use Apiv4.Web, :model
  alias Apiv4.Repo
  alias Apiv4.User
  alias Apiv4.Account
  @primary_key false
  schema "virtual:session-authentication" do
    belongs_to :user, Apiv4.User
    belongs_to :account, Apiv4.Account
    belongs_to :employee, Apiv4.Employee
    field :id, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :remember_me, :boolean
    field :remember_token, :string
  end

  @create_fields ~w(email password)
  @update_fields ~w(account_id employee_id)
  @optional_fields ~w(remember_me remember_token)

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, @create_fields, @optional_fields)
    |> validate_user_authenticity
    |> cache_user_fields
  end

  def update_changeset(model, params\\:empty) do 
    model
    |> cast(params, [], @update_fields)
    |> validate_account_ownership
  end

  def validate_account_ownership(changeset) do
    changeset 
    |> get_field(:account_id)
    |> case do
      nil -> changeset
      id ->
        account = Repo.get(Account, id)
        user = changeset.model |> Map.get(:user)
        if account |> employs?(user) do
          changeset |> put_change(:account, account)
        else
          changeset |> add_error(:account_id, "not affliated with that account")
        end
    end
  end

  def employs?(%{user_id: id}, %{id: id}), do: true
  def employs?(account, user) do
    account 
    |> assoc(:employees) 
    |> Repo.get_by(user_id: user.id)
    |> case do
      nil -> false
      _ -> true
    end
  end

  def validate_user_authenticity(%{valid?: false}=c), do: c
  def validate_user_authenticity(changeset) do
    email = changeset |> get_field(:email)
    token = changeset |> get_field(:remember_token)
    case {email, token} do
      {nil, nil} ->
        changeset
        |> add_error(:email, "cannot be blank without a remember token")
      {email, _} when is_binary(email) -> 
        user = Repo.get_by(User, email: email)
        changeset |> validate_authenticity(user)
      {_, token} when is_binary(token) ->
        user = Repo.get_by(User, remember_token: token)
        changeset |> validate_existence(user)
    end
  end

  def validate_existence(changeset, nil) do
    changeset |> add_error(:remember_token, "invalid token")
  end
  def validate_existence(changeset, user) do
    changeset |> put_change(:user, user)
  end

  def validate_authenticity(changeset, nil), do: changeset |> add_error(:email, "no such user")
  def validate_authenticity(changeset, user) do
    password = changeset |> get_field(:password, "")
    case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      true -> changeset |> put_change(:user, user)
      _ -> changeset |> add_error(:password, "wrong password")
    end
  end

  def cache_user_fields(%{valid?: false}=x), do: x
  def cache_user_fields(changeset) do
    %{remember_token: token, email: email, id: user_id} = changeset 
    |> get_field(:user) 
    changeset 
    |> put_change(:remember_token, token)
    |> put_change(:email, email)
    |> put_change(:user_id, user_id)
    |> put_change(:id, user_id)
  end
end