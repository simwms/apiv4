defmodule Apiv4.AppointmentSeed do

  def truck_seed(%{"golive_at" => golive_at}, %{account_id: account_id}) do
    %{"golive_at" => golive_at, "account_id" => account_id}
  end
  def weighticket_seed(params, model), do: truck_seed(params, model)
  def sow(params, model) do
    params
    |> Map.put("truck", truck_seed(params, model))
    |> Map.put("weighticket",  weighticket_seed(params, model))
  end
end