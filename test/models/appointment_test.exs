defmodule Apiv4.AppointmentTest do
  use Apiv4.ModelCase
  alias Apiv4.Appointment

  test "creation should work" do
    account = build_account
    company = build_company account
    appointment_params = %{
      "external_reference" => "fajskdf234",
      "company_id" => company.id,
      "golive_at" => Ecto.DateTime.utc
    }
    account
    |> build(:appointments)
    |> Appointment.create_changeset(appointment_params)
    |> Repo.insert
    |> case do
      {:ok, appointment} ->
        assert appointment.company_name == company.name
        appointment = appointment 
        |> Repo.preload([:truck, :weighticket])
        assert appointment.truck.appointment_id == appointment.id
        assert appointment.truck.golive_at == appointment.golive_at
        assert appointment.weighticket.appointment_id == appointment.id
        assert appointment.weighticket.golive_at == appointment.golive_at
      {:error, changeset} ->
        refute changeset
    end
  end

end