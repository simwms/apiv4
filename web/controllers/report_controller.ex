defmodule Apiv4.ReportController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Report when action in [:show, :update, :delete]
  use Autox.ResourceController
  
end