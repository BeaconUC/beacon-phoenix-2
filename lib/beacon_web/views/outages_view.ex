defmodule BeaconWeb.OutageView do
  alias Beacon.Iam.Profile
  alias Beacon.Ops.Outage

  def render(outages) when is_list(outages) do
    Enum.map(outages, &render_one(&1))
  end

  def render(outage) do
    render_one(outage)
  end

  defp render_one(%Outage{} = outage) do
    %{
      public_id: outage.public_id,
      outage_type: outage.outage_type,
      status: outage.status,
      confidence_percentage: outage.confidence_percentage,
      title: outage.title,
      description: outage.description,
      number_of_reports: outage.number_of_reports,
      estimated_affected_population: outage.estimated_affected_population,

      start_time: outage.start_time,
      estimated_restoration_time: outage.estimated_restoration_time,
      actual_restoration_time: outage.actual_restoration_time,
      created_at: outage.created_at,
      updated_at: outage.updated_at,

      provider_id: outage.provider_id,
      created_by: render_profile(outage.created_by_profile),
      confirmed_by: render_profile(outage.confirmed_by_profile),
      resolved_by: render_profile(outage.resolved_by_profile),

      affected_barangay_ids: Enum.map(outage.affected_areas || [], fn area -> area.barangay_id end),
    }
  end

  defp render_profile(%Profile{} = profile) do
    %{
      public_id: profile.public_id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      role: profile.role,
      phone_number: profile.phone_number
    }
  end

  defp render_profile(_), do: nil
end
