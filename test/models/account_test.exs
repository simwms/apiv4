defmodule Apiv4.AccountTest do
  use Apiv4.ModelCase
  alias Apiv4.Account

  test "creation should work" do
    build_user
    |> build(:accounts)
    |> Account.create_changeset(account_params)
    |> Repo.insert
    |> case do
      {:ok, account} ->
        account = account 
        |> Repo.preload([:walls, :roads, :desks, :gates, :docks, :cells, :scales, :user])
        assert account.user
        assert Enum.count(account.walls) > 0
        assert Enum.count(account.roads) > 0
        assert Enum.count(account.desks) > 0
        assert Enum.count(account.gates) > 0
        assert Enum.count(account.docks) > 0
        assert Enum.count(account.cells) > 0
        assert Enum.count(account.scales) > 0
      {:error, changeset} ->
        refute changeset
    end
  end

  test "update should handle stripe" do
    %{id: id} = build_service_plan
    build_account
    |> Account.update_changeset(%{"service_plan_id" => id})
    |> Repo.update
    |> case do
      {:ok, account} ->
        assert %{id: ^id} = account |> assoc(:service_plan) |> Repo.one
        assert account.stripe_subscription_id
      {:error, changeset} ->
        refute changeset
    end
  end

  test "cancelling subscriptions" do
    %{account: account} = build_account |> relate(build_service_plan)
    account
    |> Account.delete_changeset
    |> Repo.update
    |> case do
      {:ok, account} ->
        assert account.id
        assert account.deleted_at
        refute account.stripe_subscription_id
      {:error, changeset} ->
        refute changeset
    end
  end
end