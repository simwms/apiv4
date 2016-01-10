defmodule Apiv4.AccountDetail do
  use Apiv4.Web, :model
  use Ecto.Model.Callbacks
  alias Apiv4.Repo
  schema "accounts" do
    field :employee_count, :integer, virtual: true
    field :dock_count, :integer, virtual: true
    field :cell_count, :integer, virtual: true
    field :scale_count, :integer, virtual: true

    has_many :employees, Apiv4.Employee
    has_many :docks, Apiv4.Dock
    has_many :cells, Apiv4.Cell
    has_many :scales, Apiv4.Scale
    timestamps
  end

  @create_fields ~w()
  @update_fields @create_fields
  @optional_fields ~w()

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

  after_load :calculate_virtuals
  def calculate_virtuals(account) do
    query = from x in assoc(account, :employees),
      select: count(x.id)
    employees = query |> Repo.one!

    query = from x in assoc(account, :docks),
      select: count(x.id)
    docks = query |> Repo.one!

    query = from x in assoc(account, :cells),
      select: count(x.id)
    cells = query |> Repo.one!

    query = from x in assoc(account, :scales), 
      select: count(x.id)
    scales = query |> Repo.one!

    account
    |> Map.put(:employee_count, employees)
    |> Map.put(:dock_count, docks)
    |> Map.put(:cell_count, cells)
    |> Map.put(:scale_count, scales)
  end
end