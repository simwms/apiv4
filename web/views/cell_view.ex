defmodule Apiv4.CellView do
  use Apiv4.Web, :view
  
  @relationships ~w( cameras histories batches )a
  use Autox.ResourceView
  
end