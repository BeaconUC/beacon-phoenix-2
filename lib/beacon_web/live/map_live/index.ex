defmodule BeaconWeb.MapLive.Index do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.map flash={@flash} current_scope={@current_scope}>
      <.vue
        v-component="BeaconMap"
        v-socket={@socket}
        v-ssr={false}
        reports={@outage_reports}
        form={@form}
        class="h-full"
      />
    </Layouts.map>
    """
  end

  # @impl true
  # def mount(_params, _session, socket) do
  #   # if connected?(socket) do
  #   #   Maps.subscribe_maps(socket.assigns.current_scope)
  #   # end

  #   {:ok,
  #    socket
  #    |> assign(:page_title, "Listing Maps")
  #    |> assign(:overflow_hidden, true)
  #   #  |> stream(:maps, list_maps(socket.assigns.current_scope))
  #   }
  # end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Ops.subscribe_outage_reports(socket.assigns.current_scope)
    end

    initial_form =
      Ops.change_outage_report(socket.assigns.current_scope, %Beacon.Ops.OutageReport{})
      |> to_form(as: :outage_report)

    {:ok,
      socket
      |> assign(:page_title, "Map")
      |> assign(:overflow_hidden, true)
      |> assign(:outage_reports, list_outage_reports(socket.assigns.current_scope))
      |> assign(:form, initial_form)
    }
  end

  @impl true
  def handle_info({:outage_report_created, report}, socket) do
    new_reports = [report | socket.assigns.outage_reports]
    {:noreply, assign(socket, :outage_reports, new_reports)}
  end

  @impl true
  def handle_info({:outage_report_updated, updated_report}, socket) do
    new_reports = Enum.map(socket.assigns.outage_reports, fn r ->
      if r.id == updated_report.id, do: updated_report, else: r
    end)
    {:noreply, assign(socket, :outage_reports, new_reports)}
  end

  @impl true
  def handle_info({:outage_report_deleted, deleted_report}, socket) do
    new_reports = Enum.reject(socket.assigns.outage_reports, &(&1.id == deleted_report.id))
    {:noreply, assign(socket, :outage_reports, new_reports)}
  end

  defp list_outage_reports(current_scope) do
    Ops.list_outage_reports(current_scope)
  end
end
