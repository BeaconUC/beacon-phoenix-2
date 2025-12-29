defmodule BeaconWeb.OutageReportLive.Show do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
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
    if connected?(socket) do
      Ops.subscribe_outage_reports(socket.assigns.current_scope, id)
    end

    {:ok,
     socket
     |> assign(:page_title, "Show Outage report")
     |> assign(:outage_report, Ops.get_outage_report!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info({:outage_report_updated, report}, socket) do
    {:noreply, assign(socket, :outage_report, report)}
  end

  @impl true
  def handle_info({:outage_report_deleted, _report}, socket) do
    {:noreply,
      socket
      |> put_flash(:info, "This report has been deleted.")
      |> push_navigate(to: ~p"/outage_reports")}
  end

  @impl true
  def handle_info({_event, _report}, socket) do
    {:noreply, socket}
  end
end
