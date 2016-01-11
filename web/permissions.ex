defmodule Apiv4.Permissions do
  alias Autox.BroadcastSessionPlug, as: Bsp
  alias Autox.SessionUtils, as: Su

  def warehouse_employee?(conn) do
    conn 
    |> Su.current_session 
    |> Map.get(:account)
    |> valid?
  end
  def warehouse_management?(conn), do: warehouse_employee?(conn)

  defp valid?(%{id: id}) when not is_nil(id), do: true
  defp valid?(_), do: false

  def live?(conn) do
    Bsp.ok?(conn) && conn.assigns |> Map.get(:data) |> fresh?
  end
  
  def fresh?(nil), do: false
  def fresh?(%{golive_at: time_to_live, unlive_at: time_to_die}) do
    Ecto.DateTime.utc |> between?(time_to_live, time_to_die)
  end

  def between?(_, nil, nil), do: false
  def between?(x, nil, finish) when not is_nil(finish), do: x < finish
  def between?(x, start, nil) when not is_nil(start), do: start < x
  def between?(x, start, finish), do: start < x && x < finish
end