defmodule Apiv4.Session do
  use Apiv4.Web, :model
  alias Apiv4.Repo
  alias Apiv4.User
  alias Apiv4.Account
  use Autox.Session,
    repo: Repo,
    user: User
  schema "sessions" do
    belongs_to :user, Apiv4.User
    belongs_to :account, Apiv4.Account
    belongs_to :employee, Apiv4.Employee
    field :email, :string
    field :remember_token, :string
    field :password, :string, virtual: true
    field :remember_me, :boolean, virtual: true
    timestamps
  end

  @create_fields ~w(email password)
  @update_fields ~w(account_id employee_id)
  @optional_fields ~w(remember_me remember_token) ++ @update_fields
  @preload_fields ~w(account employee user)a

  def preload_fields, do: @preload_fields

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, [], @optional_fields ++ @create_fields)
    |> validate_at_least_one(["email", "remember_token"])
    |> validate_user_authenticity
    |> cache_user_fields
    |> validate_account_ownership
  end

  def update_changeset(model, params\\:empty) do 
    model
    |> cast(params, [], @update_fields)
    |> validate_at_least_one(@update_fields)
    |> validate_account_ownership
  end

  def validate_account_ownership(changeset) do
    changeset 
    |> get_field(:account_id)
    |> case do
      nil -> {:done, changeset}
      id -> {:ok, id}
    end
    |> case do
      {:ok, id} -> 
        account = Repo.get(Account, id)
        user = changeset |> get_field(:user)
        {:ok, account, user}
      other -> other
    end
    |> case do
      {:ok, nil, _} -> {:done, changeset |> add_error(:account_id, "no such account")}
      {:ok, _, nil} -> {:done, changeset |> add_error(:user_id, "missing user")}
      {:ok, account, user} -> {:ok, account |> employs?(user)}
      other -> other
    end
    |> case do
      {:ok, true} -> changeset
      {:ok, _} -> changeset |> add_error(:account_id, "not affliated with that account")
      {:done, changeset} -> changeset
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
end