defmodule BeaconWeb.MapLive.Index do
  use BeaconWeb, :live_view

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #     <Layouts.map flash={@flash} current_scope={@current_scope}>
  #       <.live_component
  #         module={MapComponent}
  #         id="map-component"
  #       />
  #     </Layouts.map>
  #   """
  # end

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   <Layouts.map flash={@flash} current_scope={@current_scope}>
  #     <div style="width:100%; height: 80vh"
  #       id="map"
  #       phx-hook="Maplibre"
  #       phx-update="ignore" />

  #     <div class="mt-4 space-y-2">
  #       <div :if={@selected_barangay} class="p-4 border-l-4 border-blue-500 rounded-lg bg-blue-50">
  #         <h3 class="font-semibold text-blue-900">
  #           Selected: <%= @selected_barangay.name %> (ID: <%= @selected_barangay.id %>)
  #         </h3>
  #         <.button phx-click="report_outage" phx-value-barangay_id={@selected_barangay.id}>
  #           🚨 Report Outage
  #         </.button>
  #       </div>
  #     </div>
  #   </Layouts.map>
  #   """
  # end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.map flash={@flash} current_scope={@current_scope}>
      <LiveSvelte.svelte name="BeaconMap" class="absolute inset-0 mt-12" />
    </Layouts.map>
    """
  end

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   <Layouts.map flash={@flash} current_scope={@current_scope}>
  #     <div class="relative flex-1">
  #       <div
  #         :if={@selected_barangay}
  #         class="absolute inset-0 z-40 backdrop-blur-xs"
  #         phx-click="clear_selection"
  #       />

  #       <div
  #         class="absolute inset-0"
  #         id="baguio-map-root"
  #         phx-hook="BaguioMap"
  #         phx-update="ignore"
  #       />

  #       <div class={[
  #         "absolute inset-y-0 right-0 w-96 bg-white border-l-2 border-gray-200 shadow-2xl transition-all duration-300 z-50",
  #         if(@selected_barangay,
  #           do: "translate-x-0 opacity-100 pointer-events-auto",
  #           else: "translate-x-full opacity-0 pointer-events-none"
  #         )
  #       ]}>
  #         <div :if={@selected_barangay} class="flex flex-col h-full p-6">
  #           <div class="flex items-center justify-between pb-4 mb-6 border-b">
  #             <h2 class="text-2xl font-bold text-gray-900">Barangay Details</h2>
  #             <.button phx-click="clear_selection" class="p-1 -m-1 text-gray-500 hover:text-gray-700">
  #               ✕
  #             </.button>
  #           </div>

  #           <div class="flex-1 space-y-4 overflow-y-auto">
  #             <div class="p-4 border border-blue-200 rounded-lg bg-blue-50">
  #               <h3 class="mb-2 text-lg font-bold text-blue-900">
  #                 {@selected_barangay.name || "Click a barangay"}
  #               </h3>
  #               <p class="inline-block px-3 py-1 text-sm text-blue-800 bg-blue-100 rounded-full">
  #                 ID: {@selected_barangay.id}
  #               </p>
  #             </div>

  #   <!-- Buttons always there but non-interactive when closed -->
  #             <div class="space-y-3">
  #               <.button
  #                 phx-click="report_outage"
  #                 phx-value-barangay_id={@selected_barangay.id}
  #                 class="w-full px-4 py-3 font-medium text-white bg-red-600 rounded-lg hover:bg-red-700"
  #               >
  #                 🚨 Report Power Outage
  #               </.button>
  #             </div>
  #           </div>
  #         </div>
  #       </div>
  #     </div>
  #   </Layouts.map>
  #   """
  # end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Beacon | Map", selected_barangay: nil)
     |> assign(:overflow_hidden, true)}
  end

  @impl true
  def handle_event("barangay_selected", %{"id" => id, "name" => name}, socket) do
    {:noreply,
     socket
     |> assign(:selected_barangay, %{id: id, name: name})
     |> put_flash(:info, "Selected: #{name} (ID: #{id})")}
  end

  @impl true
  def handle_event("report_outage", %{"barangay_id" => id}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Outage reported for barangay #{id}")
     |> assign(selected_barangay: nil)
     |> push_event("add_outage_marker", %{lat: 16.4023, lng: 120.5960, id: id})}
  end

  # @impl true
  # def handle_event("clear_selection", _params, socket) do
  #   {:noreply, assign(socket, selected_barangay: nil)}
  # end

  @impl true
  def handle_event("view_reports", %{"barangay_id" => id}, socket) do
    {
      :noreply,
      socket
      |> put_flash(:info, "Loading reports for barangay #{id}...")
      # TODO: Load reports
    }
  end

  @impl true
  def handle_event("clear_selection", _params, socket) do
    {:noreply,
     socket
     |> assign(:selected_barangay, nil)
     |> push_event("clear_selection", %{})}
  end
end
