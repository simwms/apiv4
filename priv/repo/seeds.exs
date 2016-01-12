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

User
|> struct
|> User.create_changeset(%{"email" => "test@test.test", "password" => "password123"})
|> Repo.insert!

ServicePlan
|> struct
|> ServicePlan.create_changeset(%{
  "name" => "Default Free Test Plan",
  "description" => "Seed generated free test plan"
})
|> Repo.insert!