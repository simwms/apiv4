defmodule Apiv4.AccountSeed do
  @dock_seeds [%{"height" => 1, "width" => 1, "x" => 7, "y" => 2 }]

  @scale_seeds [%{"height" => 1, "width" => 1, "x" => 16, "y" => 2 }]

  @gate_seeds [
    %{"height" => 1, "width" => 1, "x" => 0, "y" => 0},
    %{"height" => 1, "width" => 1, "x" => 19, "y" => 13}]

  @cell_seeds [
    %{"height" => 1, "width" => 1, "x" => 6, "y" => 6},
    %{"height" => 1, "width" => 1, "x" => 6, "y" => 7},
    %{"height" => 1, "width" => 1, "x" => 7, "y" => 7},
    %{"height" => 1, "width" => 1, "x" => 7, "y" => 6}]

  @desk_seeds [
    %{"height" => 1, "width" => 1, "x" => 15, "y" => 6},
    %{"height" => 1, "width" => 1, "x" => 15, "y" => 7},
    %{"height" => 1, "width" => 1, "x" => 15, "y" => 8}]

  @road_seeds [
    %{ "points" => "0,0 2,7",  "x" => 17, "y" => 1},
    %{ "points" => "0,0 0,6",  "x" => 19, "y" => 8},
    %{ "points" => "0,0 17,0", "x" => 0,  "y" => 1}]
  
  @wall_seeds [
    %{ "points" => "0,0 0,-5", "x" => 17, "y" => 10},
    %{ "points" => "0,0 3,0",  "x" => 14, "y" => 10},
    %{ "points" => "0,0 3,0",  "x" => 14, "y" => 5},
    %{ "points" => "0,0 0,7",  "x" => 14, "y" => 3},
    %{ "points" => "0,0 13,0", "x" => 1,  "y" => 10},
    %{ "points" => "0,0 0,7",  "x" => 1,  "y" => 3},
    %{ "points" => "0,0 13,0", "x" => 1,  "y" => 3}]

  @employee_seeds [
    %{"role" => "admin", "name" => "admin", "confirmed" => true}
  ]
  def employee_seeds(%{user_id: user_id}) do
    @employee_seeds 
    |> Enum.map(&Map.put(&1, "user_id", user_id))
  end
  def sow(params, model) do
    params
    |> Map.put("employees", employee_seeds(model))
    |> Map.put("docks",  @dock_seeds)
    |> Map.put("scales", @scale_seeds)
    |> Map.put("gates",  @gate_seeds)
    |> Map.put("cells",  @cell_seeds)
    |> Map.put("desks",  @desk_seeds)
    |> Map.put("roads",  @road_seeds)
    |> Map.put("walls",  @wall_seeds)
  end
end