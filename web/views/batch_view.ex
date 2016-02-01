defmodule Apiv4.BatchView do
  use Apiv4.Web, :view
  
  @relationships ~w( pictures histories cell in_appointment out_appointment )a
  use Autox.ResourceView
  
end