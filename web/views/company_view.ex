defmodule Apiv4.CompanyView do
  use Apiv4.Web, :view
  
  @relationships ~w( appointments )a
  use Autox.ResourceView
  
end