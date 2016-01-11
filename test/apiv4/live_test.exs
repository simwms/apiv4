defmodule Apiv4.LiveTest do
  use Apiv4.ModelCase
  import Apiv4.Permissions
  alias Apiv4.Batch

  def xx(model), do: %{status: 200, assigns: %{data: model}}
  test "fresh?" do
    now = Ecto.DateTime.utc
    tomorrow = %{now|day: now.day + 1}
    yesterday = %{now|day: now.day - 1}
    ototoi = %{now|day: now.day - 2}

    assert ototoi < yesterday
    assert yesterday < now
    assert now < tomorrow

    refute ototoi > yesterday
    refute yesterday > now
    refute now > tomorrow

    refute %Batch{} |> xx |> live?
    assert %Batch{golive_at: yesterday} |> xx |> live?
    refute %Batch{golive_at: tomorrow} |> xx |> live?
    assert %Batch{golive_at: yesterday, unlive_at: tomorrow} |> xx |> live?
    refute %Batch{golive_at: ototoi, unlive_at: yesterday} |> xx |> live?
  end
end