defmodule Apiv4.SeedSupport do
  alias Apiv4.Repo
  alias Apiv4.User
  alias Apiv4.ServicePlan
  alias Apiv4.Account
  alias Apiv4.Company
  import Ecto.Model
  import Ecto.Query, only: [from: 2]
  def service_plan_params do
    %{"name" => "generic test plan"}
  end

  def user_params do
    %{"email" => "apiv4-auto-test@test.co", "password" => "password123"}
  end

  def account_params do
    %{"name" => "apiv4-test-warehouse", "timezone" => "America/Los_Angeles"}
  end

  def company_params do
    %{"name" => "apiv4-test-company"}
  end

  def build_user do
    User
    |> struct
    |> User.create_changeset(user_params)
    |> Repo.insert!
  end

  def build_account(user\\build_user) do
    user
    |> build(:accounts)
    |> Account.create_changeset(account_params)
    |> Repo.insert!
  end

  def build_company(account\\build_account) do
    account
    |> build(:companies)
    |> Company.create_changeset(company_params)
    |> Repo.insert!
  end

  def build_service_plan do
    ServicePlan
    |> struct
    |> ServicePlan.create_changeset(service_plan_params)
    |> Repo.insert!
  end

  def relate(%Account{}=a, %ServicePlan{}=s) do
    account = Account.update_changeset(a, %{"service_plan_id" => s.id}) |> Repo.update!
    %{account: account, service_plan: s}
  end
end