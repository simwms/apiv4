defmodule Apiv4.LineController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Line when action in [:show, :update, :delete]
  use Autox.ResourceController
  
end