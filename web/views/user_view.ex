defmodule Apiv4.UserView do
  use Apiv4.Web, :view
  
  @relationships ~w( employees accounts )a
  use Autox.ResourceView
  
end