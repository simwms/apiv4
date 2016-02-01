defmodule Apiv4.AppointmentView do
  use Apiv4.Web, :view
  
  @relationships ~w( pictures histories in_batches out_batches company weighticket truck )a
  use Autox.ResourceView
  
end