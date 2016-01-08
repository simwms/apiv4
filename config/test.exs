use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :apiv4, Apiv4.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :apiv4, Apiv4.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ia",
  password: "1234567",
  database: "apiv4_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
