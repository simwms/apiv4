defmodule Apiv4.ReportController do
  use Apiv4.Web, :controller
  @repo Autox.EchoRepo
  alias Apiv4.Repo
  alias Apiv4.ReportQuery
  plug :scrub_params, "data" when action in [:create, :update]
  plug Autox.AutoModelPlug, Apiv4.Report when action in [:show, :update, :delete]
  use Autox.ResourceController
  
  def show(conn, %{"model" => report}=params) do
    account = report |> assoc(:account) |> Repo.one
    appointments = account
    |> assoc(:appointments) 
    |> ReportQuery.appointments(report) 
    |> Repo.all
    assigns = report |> Map.take([:golive_at, :unlive_at]) |> Map.put(:appointments, appointments)
    conn
    |> Phoenix.Controller.put_layout("print.html")
    |> render("show.html", assigns)
  end
end