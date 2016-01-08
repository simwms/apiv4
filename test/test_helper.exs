ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Apiv4.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Apiv4.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Apiv4.Repo)

