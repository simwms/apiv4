defmodule Apiv4.WeighticketView do
  use Apiv4.Web, :view
  
  @relationships ~w(appointment)a
  use Autox.ResourceView
  
end