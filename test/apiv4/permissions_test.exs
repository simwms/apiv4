defmodule Apiv4.PermissionsTest do
  alias Autox.SessionUtils
  use Apiv4.ConnCase
  import Apiv4.Permissions

  setup do
    user = build_user
    attributes = %{
      "email" => user.email,
      "password" => "password123"
    }
    conn = conn()
    |> post("/api/sessions", %{"data" => %{"type" => "sessions", "attributes" => attributes}})
    {:ok, conn: conn, user: user}
  end
  test "warehouse_employee?", %{conn: conn, user: user} do
    assert {:error, nil} == conn |> SessionUtils.current_session |> warehouse_employee?
    account = build_account(user)
    relationships = %{
      "account" => %{
        "data" => %{
          "id" => account.id,
          "type" => "accounts"
        }
      }
    }
    assert {:ok, _} = conn
    |> put("/api/sessions", %{"data" => %{"type" => "sessions", "relationships" => relationships}})
    |> SessionUtils.current_session
    |> warehouse_employee?
  end
end