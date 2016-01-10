defmodule Apiv4.UserTest do
  use Apiv4.ModelCase
  alias Apiv4.User

  test "it should create properly" do
    User
    |> struct
    |> User.create_changeset(user_params)
    |> Repo.insert
    |> case do
      {:ok, user} ->
        assert user.id
        assert user.email
        assert user.stripe_customer_id
      {:error, changeset} ->
        refute changeset.errors
    end
  end
end