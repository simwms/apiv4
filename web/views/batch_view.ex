defmodule Apiv4.BatchView do
  use Apiv4.Web, :view
  
  @relationships ~w( pictures histories )a
  use Autox.ResourceView
  
end