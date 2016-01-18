defmodule Apiv4.ReportQuery do
  alias Autox.QueryUtils
  alias Fox.MapExt
  alias Fox.DictExt

  def appointments(query, report) do
    params = report
    |> Map.take([:golive_at, :unlive_at])
    |> MapExt.present_update(:golive_at, &(">#{&1}"))
    |> MapExt.present_update(:unlive_at, &("<#{&1}"))
    |> DictExt.key_map(&Atom.to_string/1)
    query
    |> QueryUtils.construct(%{"filter" => params})
  end
end