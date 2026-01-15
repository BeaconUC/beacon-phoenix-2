defmodule BeaconWeb.OutageReportView do
  alias Beacon.Ops.OutageReport

  def render(outage_reports) when is_list(outage_reports) do
    Enum.map(outage_reports, &render_one(&1))
  end

  def render(outage_report) do
    render_one(outage_report)
  end

  defp render_one(%OutageReport{} = report) do
    %{
      public_id: report.public_id,
      description: report.description,
      status: report.status,
      location: render_location(report.location),
      reported_at: report.created_at,
      barangay_id: report.barangay_id
    }
  end

  defp render_location(%Geo.Point{coordinates: {lng, lat}}) do
    %{lat: lat, lng: lng}
  end

  defp render_location(_), do: nil
end
