defmodule BeaconWeb.MapLive.Show do
  use BeaconWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Beacon Outage Map
        <:subtitle>Interactive barangay boundaries around Baguio City.</:subtitle>
        <:actions>
          <.button navigate={~p"/maps"}>
            <.icon name="hero-arrow-left" />
          </.button>
        </:actions>
      </.header>

      <div class="mt-8 h-[500px] w-full border rounded-lg overflow-hidden"
        id={"map-#{@map.id}"}
        phx-hook="Maplibre"
        data-center="120.5960,16.4023"
        data-zoom="12">
      </div>
    </Layouts.app>
    """
  end

  # @impl true
  # def mount(%{"id" => id}, _session, socket) do
  #   if connected?(socket) do
  #     Maps.subscribe_maps(socket.assigns.current_scope)
  #   end

  #   {:ok,
  #     socket
  #     |> assign(:page_title, "Show Map")
  #     |> assign(:map, Maps.get_map!(socket.assigns.current_scope, id))}
  # end

   @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Beacon Map Viewer")}
  end

  # @impl true
  # def handle_info(
  #       {:updated, %Beacon.Maps.Map{id: id} = map},
  #       %{assigns: %{map: %{id: id}}} = socket
  #     ) do
  #   {:noreply, assign(socket, :map, map)}
  # end

  # def handle_info(
  #       {:deleted, %Beacon.Maps.Map{id: id}},
  #       %{assigns: %{map: %{id: id}}} = socket
  #     ) do
  #   {:noreply,
  #     socket
  #     |> put_flash(:error, "The current map was deleted.")
  #     |> push_navigate(to: ~p"/maps")}
  # end

  # def handle_info({_type, _struct}, socket)
  #     when type in [:created, :updated, :deleted] do
  #   {:noreply, socket}
  # end

  # def handle_info({_type, _struct}, socket)do
  #   {:noreply, socket}
  # end
end
