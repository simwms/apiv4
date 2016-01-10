# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :apiv4, Apiv4.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "Wwo3Zfx1bvk77yEZeorWw9Hdvkx014M2WAUYjlYIWjo10/z9J8gUmAMGE03MhvK7",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Apiv4.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :plug, :mimes, %{"application/vnd.api+json" => ["json-api"]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :gateway, Stripex,
  url: "https://api.stripe.com",
  secret_key: "Bearer sk_test_GINswumlSKmkYRJ3lnno7Cqx"

## Autox Installed
config :plug, :mimes, %{"application/vnd.api+json" => ["json-api"]}
config :autox, Autox.Defaults,
  repo: Apiv4.Repo,
  session_header: "autox-remember-token",
  simwms_master_key: "some-secret-key",
  error_view: Apiv4.ErrorView,
  user_class: Apiv4.User,
  endpoint: Apiv4.Endpoint,
  session_class: Apiv4.Session
## End Autox

