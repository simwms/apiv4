defmodule Apiv4.SessionControllerTest do
  use Apiv4.ConnCase
  alias Autox.SessionUtils, as: Su
  import Apiv4.SeedSupport
  
  setup do
    conn = conn()
    {:ok, conn: conn, user: build_user}
  end

  test "session update", %{conn: conn, user: user} do
    account = build_account(user)
    data = %{
      "type" => "sessions",
      "attributes" => %{"email" => user.email, "password" => "password123"}
    }
    conn = conn
    |> post("/api/sessions", %{"data" => data})

    assert conn |> Su.logged_in?

    data = %{
      "type" => "sessions",
      "relationships" => %{
        "account" => %{
          "data" => %{ "id" => account.id, "type" => "accounts" }
        }
      }
    }
    conn = conn
    |> ensure_recycled
    |> put("/api/sessions", %{"data" => data})

    session = conn
    |> ensure_recycled
    |> get("/api/sessions", %{})
    |> Su.current_session

    assert session
    assert session |> Map.get(:user)
    assert session |> Map.get(:account) |> Map.get(:id)
    assert {:ok, _} = session |> Apiv4.Permissions.warehouse_employee?
  end
end