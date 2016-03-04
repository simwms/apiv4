defmodule Apiv4.GateController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Gate when action in [:show, :update, :delete]
  plug Autox.AutoPaginatePlug, [limit: 200, max_limit: 5000] when action in [:index]
  use Autox.ResourceController
  
end