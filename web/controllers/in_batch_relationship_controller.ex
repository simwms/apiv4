defmodule Apiv4.InBatchRelationshipController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update, :delete]
  plug Autox.AutoPaginatePlug when action in [:index]
  plug Autox.AutoParentPlug, Apiv4
  use Autox.RelationshipController
  
end