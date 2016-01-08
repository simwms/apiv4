defmodule Apiv4.OnsiteTruckController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.OnsiteTruck when action in [:show, :update, :delete]
  use Autox.ResourceController
  
end