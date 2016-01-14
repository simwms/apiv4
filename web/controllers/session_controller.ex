defmodule Apiv4.SessionController do
  use Apiv4.Web, :controller
  @repo Autox.EchoRepo
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.ChangeSessionPlug when action in [:create, :update, :delete]
  plug Autox.SessionModelPlug when action in [:show, :update, :delete]
  plug :fuckyou when action in [:update]
  use Autox.ResourceController

  def fuckyou(conn, _) do
    conn |> register_before_send(fn 
      %{status: 200}=c -> %{c|status: 201}
      c -> c
    end)
  end
end