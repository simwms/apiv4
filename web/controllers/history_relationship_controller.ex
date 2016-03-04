defmodule Apiv4.HistoryRelationshipController do
  use Apiv4.Web, :controller
  
  plug :scrub_params, "data" when action in [:create, :update, :delete]
  plug Autox.AutoParentPlug, Apiv4
  plug Autox.AutoPaginatePlug, [limit: 75, max_limit: 125] when action in [:index]
  use Autox.RelationshipController
  
end