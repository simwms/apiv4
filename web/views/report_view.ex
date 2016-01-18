defmodule Apiv4.ReportView do
  use Apiv4.Web, :view
  
  @relationships ~w( )a
  use Autox.ResourceView
  def infer_status_message(appointments) do
    "not implemented"
  end
  def material_description(appointments) do
    "not implemented"
  end
  def appointment_type(appointments) do
    "not implemented"
  end
  def planned_filter(appointments) do
    []
  end
  def ongoing_filter(appointments) do
    []
  end
  def problem_filter(appointments) do
    []
  end
  def missing_filter(appointments) do
    []
  end
  def cancelled_filter(appointments) do
    []
  end
  def fulfiled_filter(appointments) do
    []
  end
  def incoming_batches(appointments) do
    []
  end
  def outgoing_batches(appointments) do
    []
  end
  def all_batches(appointments) do
    []
  end
  def storage_position(batch) do
    "not implemented"
  end
  def appt_permalink(batch) do
    "not implemented"
  end
  def fa_class(appointment) do
    "fa-question"
  end
end