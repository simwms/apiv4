defmodule Apiv4.GateView do
  use Apiv4.Web, :view
  
  @relationships ~w( cameras histories )a
  use Autox.ResourceView
  
end