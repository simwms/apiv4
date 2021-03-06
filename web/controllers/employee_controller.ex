defmodule Apiv4.EmployeeController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Employee when action in [:show, :update, :delete]
  plug Autox.AutoPaginatePlug when action in [:index]
  use Autox.ResourceController
  
end