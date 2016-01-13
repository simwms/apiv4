defmodule Apiv4.Endpoint do
  use Phoenix.Endpoint, otp_app: :apiv4

  socket "/socket", Apiv4.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :apiv4, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  ## Autox Installed
  @cors_headers ~w()
  plug CORSPlug, [origin: Autox.default_origin, expose: ["_apiv4_key"]]
  ## End Autox

  plug Plug.Session,
    store: :cookie,
    key: "_apiv4_key",
    signing_salt: "mUGXjsdd",
    http_only: false

  plug Apiv4.Router
end
