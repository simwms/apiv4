defmodule Apiv4.DeskView do
  use Apiv4.Web, :view
  
  @relationships ~w( cameras histories )a
  use Autox.ResourceView
  
end