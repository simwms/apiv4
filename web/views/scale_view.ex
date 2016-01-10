defmodule Apiv4.ScaleView do
  use Apiv4.Web, :view
  
  @relationships ~w( cameras histories )a
  use Autox.ResourceView
  
end