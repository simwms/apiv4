defmodule Apiv4.AccountView do
  use Apiv4.Web, :view
  
  @relationships ~w( service_plan )a
  use Autox.ResourceView
  
end