defmodule BeaconWeb.OutageReportLive.Index do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Outage reports
        <:actions>
          <.button variant="primary" navigate={~p"/outage_reports/new"}>
            <.icon name="hero-plus" /> New Outage report
          </.button>
        </:actions>
      </.header>

      <.table
        id="outage_reports"
        rows={@streams.outage_reports}
        row_click={fn {_id, outage_report} -> JS.navigate(~p"/outage_reports/#{outage_report}") end}
      >
        <:col :let={{_id, outage_report}} label="Description">{outage_report.description}</:col>
        <:col :let={{_id, outage_report}} label="Status">{outage_report.status}</:col>
        <:action :let={{_id, outage_report}}>
          <div class="sr-only">
            <.link navigate={~p"/outage_reports/#{outage_report}"}>Show</.link>
          </div>
          <.link navigate={~p"/outage_reports/#{outage_report}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, outage_report}}>
          <.link
            phx-click={JS.push("delete", value: %{id: outage_report.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Ops.subscribe_outage_report()

    {:ok,
     socket
     |> assign(:page_title, "Listing Outage reports")
     |> stream(:outage_reports, list_outage_reports())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    outage_report = Ops.get_outage_report!(id)

    case Ops.delete_outage_report(socket.assigns.current_scope, outage_report) do
      {:ok, _outage_report} ->
        {:noreply,
          socket
          |> put_flash(:info, "Outage report deleted successfully.")
          |> stream_delete(:outage_reports, outage_report)
        }

      {:error, :unauthorized} ->
        {:noreply, put_flash(socket, :error, "You are not authorized to delete this report.")}
    end
  end

  defp list_outage_reports() do
    Ops.list_outage_reports()
  end

  def handle_info({:outage_report_deleted, msg}, socket) do
    {:noreply, stream_delete(socket, :outage_reports, msg)}
  end

  @impl true
  def handle_info({_event, msg}, socket) do
    {:noreply, stream_insert(socket, :outage_reports, msg, at: 0)}
  end
end
