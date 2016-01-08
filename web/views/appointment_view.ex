defmodule Apiv4.AppointmentView do
  use Apiv4.Web, :view
  
  @relationships ~w( pictures histories batches weighticket truck )a
  use Autox.ResourceView
  
end