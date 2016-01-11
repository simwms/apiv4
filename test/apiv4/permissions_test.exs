defmodule Apiv4.PermissionsTest do
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
    refute conn |> warehouse_employee?
    account = build_account(user)
    relationships = %{
      "account" => %{
        "data" => %{
          "id" => account.id,
          "type" => "accounts"
        }
      }
    }
    conn
    |> put("/api/sessions", %{"data" => %{"type" => "sessions", "relationships" => relationships}})
    |> warehouse_employee?
    |> assert
  end
end