defmodule Apiv4.ServicePlanTest do
  use Apiv4.ModelCase
  alias Apiv4.ServicePlan

  test "it should create properly" do
    ServicePlan
    |> struct
    |> ServicePlan.create_changeset(service_plan_params)
    |> Repo.insert
    |> case do
      {:ok, plan} ->
        assert plan.id
        assert plan.name
        assert plan.stripe_plan_id
      {:error, changeset} ->
        refute changeset.errors
    end
  end
end