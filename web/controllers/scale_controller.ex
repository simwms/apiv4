defmodule Apiv4.ScaleController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Scale when action in [:show, :update, :delete]
  plug Autox.AutoPaginatePlug, [limit: 200, max_limit: 5000] when action in [:index]
  use Autox.ResourceController
  
end