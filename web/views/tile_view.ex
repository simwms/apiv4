defmodule Apiv4.TileView do
  use Apiv4.Web, :view
  
  @relationships ~w( employees onsite-batches onsite-trucks )a
  use Autox.ResourceView
  
end