defmodule Apiv4.SessionController do
  use Apiv4.Web, :controller
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.ChangeSessionPlug when action in [:create, :update, :delete]
  plug Autox.SessionModelPlug when action in [:show, :update, :delete]
  use Autox.ResourceController
end