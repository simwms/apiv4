defmodule Apiv4.AccountView do
  use Apiv4.Web, :view
  
  @relationships ~w( account-detail onsite-trucks onsite-batches live-appointments appointments pictures employees batches weightickets trucks lines points tiles cameras service-plan )a
  use Autox.ResourceView
  
end