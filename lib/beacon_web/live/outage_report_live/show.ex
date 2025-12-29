defmodule BeaconWeb.OutageReportLive.Show do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Outage report {@outage_report.id}
        <:subtitle>Location: {@outage_report.location}</:subtitle>
        <:actions>
          <.button navigate={~p"/outage_reports"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/outage_reports/#{@outage_report}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit outage_report
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Description">{@outage_report.description}</:item>
        <:item title="Status">{@outage_report.status}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: Ops.subscribe_outage_report(id)

    {:ok,
     socket
     |> assign(:page_title, "Show Outage report")
     |> assign(:outage_report, Ops.get_outage_report!(id))}
  end

  @impl true
  def handle_info({event, updated_report}, socket) do
    case event do
      :outage_report_updated ->
        {:noreply, assign(socket, :outage_report, updated_report)}

      :outage_report_deleted ->
        {:noreply,
        socket
        |> put_flash(:info, "This report has been deleted.")
        |> push_navigate(to: ~p"/outage_reports")}

      _ ->
        {:noreply, socket}
    end
  end
end
