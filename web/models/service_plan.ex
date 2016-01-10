defmodule Apiv4.ServicePlan do
  use Apiv4.Web, :model

  schema "service_plans" do
    field :stripe_plan_id, :string
    field :name, :string
    field :amount, :integer, default: 0
    field :interval, :string, default: "month"
    field :interval_count, :integer, default: 1
    field :currency, :string, default: "usd"
    field :docks, :integer
    field :employees, :integer
    field :cells, :integer
    field :scales, :integer
    field :description, :string
    field :presentation, :string
    
    field :deleted_at, Ecto.DateTime
    has_many :accounts, Apiv4.Account
    timestamps
  end

  @create_fields ~w(name)
  @update_fields @create_fields
  @delete_fields ~w(deleted_at)
  @optional_fields ~w(docks employees cells scales amount interval interval_count description presentation currency)

  def create_changeset(model, params\\:empty) do
    model
    |> cast(params, @create_fields, @optional_fields)
    |> initialize_stripe_plan
  end

  def update_changeset(model, params\\:empty) do 
    create_changeset(model, params)
  end

  def delete_changeset(model, _) do
    model
  end

  @statement_descriptor "simwms cloud service"
  defp initialize_stripe_plan(changeset) do
    %{
      id: changeset |> get_field(:name) |> generate_stripe_id,
      amount: changeset |> get_field(:amount),
      currency: changeset |> get_field(:currency),
      name: changeset |> get_field(:name),
      interval: changeset |> get_field(:interval),
      interval_count: changeset |> get_field(:interval_count),
      statement_descriptor: @statement_descriptor }
    |> Stripex.Plans.create
    |> case do
      {:ok, %{id: id}} ->
        changeset |> put_change(:stripe_plan_id, id)
      {:error, _} ->
        changeset |> add_error(:stripe_plan_id, "stripe plan service is shot")
    end
  end

  defp generate_stripe_id(name) do
    Ecto.DateTime.utc |> Ecto.DateTime.to_string |> Kernel.<>(name)
  end
end