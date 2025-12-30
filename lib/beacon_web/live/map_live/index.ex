defmodule BeaconWeb.MapLive.Index do
  use BeaconWeb, :live_view

  alias Beacon.Maps

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Listing Maps
        <:actions>
          <.button variant="primary" navigate={~p"/maps/new"}>
            <.icon name="hero-plus" /> New Map
          </.button>
        </:actions>
      </.header>

      <.table
        id="maps"
        rows={@streams.maps}
        row_click={fn {_id, map} -> JS.navigate(~p"/maps/#{map}") end}
      >
        <:col :let={{_id, map}} label="Dummy">{map.dummy}</:col>
        <:action :let={{_id, map}}>
          <div class="sr-only">
            <.link navigate={~p"/maps/#{map}"}>Show</.link>
          </div>
          <.link navigate={~p"/maps/#{map}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, map}}>
          <.link
            phx-click={JS.push("delete", value: %{id: map.id}) |> hide("##{id}")}
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
    if connected?(socket) do
      Maps.subscribe_maps(socket.assigns.current_scope)
    end

    {:ok,
     socket
     |> assign(:page_title, "Listing Maps")
     |> stream(:maps, list_maps(socket.assigns.current_scope))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    map = Maps.get_map!(socket.assigns.current_scope, id)
    {:ok, _} = Maps.delete_map(socket.assigns.current_scope, map)

    {:noreply, stream_delete(socket, :maps, map)}
  end

  @impl true
  def handle_info({type, %Beacon.Maps.Map{}}, socket)
      when type in [:created, :updated, :deleted] do
    {:noreply, stream(socket, :maps, list_maps(socket.assigns.current_scope), reset: true)}
  end

  defp list_maps(current_scope) do
    Maps.list_maps(current_scope)
  end
end
