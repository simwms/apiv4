defmodule Apiv4.SessionView do
  use Apiv4.Web, :view
  
  @relationships ~w( user account employee )a
  use Autox.ResourceView
  
end