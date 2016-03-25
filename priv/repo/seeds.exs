# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Apiv4.Repo.insert!(%Apiv4.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Apiv4.Repo
alias Apiv4.User
alias Apiv4.ServicePlan

user = User
|> struct
|> User.create_changeset(%{"email" => "test@test.test", "password" => "password123"})
|> Repo.insert!

ServicePlan
|> struct
|> ServicePlan.create_changeset(%{
  "name" => "Trial Free Plan",
  "description" => "The default free sampler service plan",
  "employees" => 2,
  "storage" => 100,
  "dataflow" => 1_000,
  "daily_uptime" => 18
})
|> Repo.insert!

ServicePlan
|> struct
|> ServicePlan.create_changeset(%{
  "name" => "Small Business",
  "description" => "For small warehouses with low traffic",
  "employees" => 5,
  "storage" => 1_000,
  "dataflow" => 10_000,
  "amount" => 2_500,
  "custom_domain" => true
})
|> Repo.insert!

ServicePlan
|> struct
|> ServicePlan.create_changeset(%{
  "name" => "Standard Warehouse",
  "description" => "For the common warehouses with medium traffic",
  "employees" => 15,
  "storage" => 10_000,
  "dataflow" => 100_000,
  "amount" => 7_500,
  "custom_domain" => true,
  "data_backup" => true
})
|> Repo.insert!

ServicePlan
|> struct
|> ServicePlan.create_changeset(%{
  "name" => "Trade Center",
  "description" => "For the large enterprise warehouses with high traffic",
  "employees" => 200,
  "storage" => 100_000,
  "amount" => 20_000,
  "custom_domain" => true,
  "data_backup" => true
})
|> Repo.insert!

user 
|> Ecto.build_assoc(:accounts) 
|> Apiv4.Account.create_changeset(%{"name" => "test-account", "timezone" => "Americas/Los_Angeles"}) 
|> Repo.insert!