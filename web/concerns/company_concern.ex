defmodule Apiv4.CompanyConcern do
  import Ecto.Changeset
  alias Apiv4.Repo
  alias Apiv4.Company

  def punch_company_name(changeset) do
    changeset
    |> get_field(:company_id)
    |> case do
      nil -> nil
      id ->  Repo.get(Company, id)
    end
    |> case do
      nil -> changeset
      %{name: name} -> 
        changeset |> put_change(:company_name, name)
    end
  end
end