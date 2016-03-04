defmodule Apiv4.CompanyController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Company when action in [:show, :update, :delete]
  plug Autox.AutoPaginatePlug, [limit: 200, max_limit: 1000] when action in [:index]
  use Autox.ResourceController
  
end