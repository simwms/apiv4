defmodule Apiv4.Account do
  use Apiv4.Web, :model
  alias Apiv4.AccountSeed
  alias Apiv4.Repo
  schema "accounts" do
    field :name, :string
    field :timezone, :string
    field :stripe_source, :string, virtual: true
    field :stripe_subscription_id, :string
    field :deleted_at, Ecto.DateTime

    belongs_to :user, Apiv4.User
    belongs_to :service_plan, Apiv4.ServicePlan
    has_many :walls, Apiv4.Wall
    has_many :roads, Apiv4.Road
    has_many :desks, Apiv4.Desk
    has_many :gates, Apiv4.Gate
    has_many :docks, Apiv4.Dock
    has_many :cells, Apiv4.Cell
    has_many :scales, Apiv4.Scale
    has_many :appointments, Apiv4.Appointment
    has_many :trucks, Apiv4.Truck
    has_many :batches, Apiv4.Batch
    has_many :employees, Apiv4.Employee
    has_many :weightickets, Apiv4.Weighticket
    has_many :reports, Apiv4.Report
    has_many :companies, Apiv4.Company
    timestamps
  end

  @create_fields ~w(name timezone user_id)
  @update_fields ~w(name timezone stripe_source service_plan_id)
  @delete_fields ~w(deleted_at)
  @optional_fields ~w()

  def create_changeset(model, params\\:empty) do
    params = AccountSeed.sow(params)
    model
    |> cast(params, @create_fields, @optional_fields)
    |> cast_assoc(:walls, with: &Apiv4.Wall.create_changeset/2)
    |> cast_assoc(:roads, with: &Apiv4.Road.create_changeset/2)
    |> cast_assoc(:gates, with: &Apiv4.Gate.create_changeset/2)
    |> cast_assoc(:docks, with: &Apiv4.Dock.create_changeset/2)
    |> cast_assoc(:desks, with: &Apiv4.Desk.create_changeset/2)
    |> cast_assoc(:cells, with: &Apiv4.Cell.create_changeset/2)
    |> cast_assoc(:scales, with: &Apiv4.Scale.create_changeset/2)
  end

  def update_changeset(model, params\\:empty) do 
    model
    |> cast(params, [], @update_fields)
    |> validate_stripe
  end

  def delete_changeset(model, params\\%{}) do
    params = params |> Map.put_new("deleted_at", Ecto.DateTime.utc)
    model
    |> cast(params, @delete_fields, @optional_fields)
    |> cancel_stripe
  end

  defp cancel_stripe(changeset) do
    cus_id = changeset.model |> assoc(:user) |> Repo.one |> Map.get(:stripe_customer_id)
    id = changeset |> get_field(:stripe_subscription_id)
    case {cus_id, id} do
      {nil, _} -> 
        changeset |> add_error(:user, "user is missing a stripe customer id")
      {_, nil} -> changeset
      {cus_id, id} -> Stripex.Subscriptions.delete({cus_id, id})
    end
    |> case do
      {:ok, _} -> 
        changeset |> put_change(:stripe_subscription_id, nil)
      {:error, _} ->
        changeset |> add_error(:stripe_subscription_id, "unable to cancel stripe subscription")
      changeset -> changeset
    end
  end

  defp xac({:ok, cs, ctx}, f), do: f.({cs, ctx})
  defp xac({_, _, _}=x, _), do: x
  defp validate_stripe(changeset) do
    use Pipe
    {_, changeset, _} = pipe_with &xac/2,
      validate_service_plan(changeset) 
      |> validate_stripe_source
      |> validate_stripe_customer
      |> validate_remote_stripe
    changeset
  end

  defp validate_service_plan(changeset) do
    case changeset |> get_field(:service_plan_id) do
      nil -> {:done, changeset, nil}
      id -> 
        {:ok, changeset, %{plan: Repo.get(Apiv4.ServicePlan, id)}}
    end
  end

  defp validate_stripe_source({cs, %{plan: nil}}) do
    cs = cs |> add_error(:plan, "no such service plan")
    {:done, cs, nil}
  end
  defp validate_stripe_source({cs, %{plan: plan}=ctx}) do
    source = cs |> get_field(:stripe_source)
    case {plan.amount, source} do
      {price, nil} when price > 0 ->
        cs = cs |> add_error(:source, "cannot be blank")
        {:done, cs, nil}
      {price, _} when price <= 0 ->
        {:ok, cs, ctx}
      {_, source} ->
        {:ok, cs, Map.put(ctx, :source, source)}
    end
  end

  defp validate_stripe_customer({cs, ctx}) do
    case cs |> get_field(:user_id) do
      nil ->
        cs = cs |> add_error(:user, "invalid account doesn't have an owner")
        {:done, cs, ctx}
      id ->
        %{stripe_customer_id: customer_id} = Repo.get(Apiv4.User, id)
        {:ok, cs, Map.put(ctx, :cus_id, customer_id)}
    end
  end

  defp validate_remote_stripe({changeset, %{cus_id: cus_id}=ctx}) do
    params = changeset |> make_stripe_params(ctx)
    changeset 
    |> get_field(:stripe_subscription_id)
    |> case do
      nil -> cus_id |> Stripex.Subscriptions.create(params)
      id -> {cus_id, id} |> Stripex.Subscriptions.update(params)
    end
    |> case do
      {:ok, %{id: id}} ->
        cs = changeset 
        |> put_change(:stripe_subscription_id, id) 
        {:done, cs, nil}
      {:error, _} ->
        cs = changeset 
        |> add_error(:stripe_source, "Stripe payment gateway is down for maintance")
        {:ok, cs, nil}
    end
  end

  defp make_stripe_params(changeset, %{plan: %{amount: p, stripe_plan_id: id}, source: source}) when p > 0 do
    %{plan: id,
      source: source,
      metadata: %{"account_id" => changeset |> get_field(:id)}}
  end

  defp make_stripe_params(changeset, %{plan: %{stripe_plan_id: id}}) do
    %{plan: id,
      metadata: %{"account_id" => changeset |> get_field(:id)}}
  end
end