defmodule Apiv4.AppointmentRelationshipController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update, :delete]
  plug Autox.AutoParentPlug, Apiv4
  use Autox.RelationshipController
  
end