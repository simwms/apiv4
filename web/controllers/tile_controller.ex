defmodule Apiv4.TileController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Tile when action in [:show, :update, :delete]
  use Autox.ResourceController
  
end