defmodule Apiv4.PageController do
  use Apiv4.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
