defmodule BeaconWeb.OutageLive.Show do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Outage {@outage.id}
        <:subtitle>This is a outage record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/outages"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/outages/#{@outage}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit outage
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Outage type">{@outage.outage_type}</:item>
        <:item title="Status">{@outage.status}</:item>
        <:item title="Confidence percentage">{@outage.confidence_percentage}</:item>
        <:item title="Title">{@outage.title}</:item>
        <:item title="Description">{@outage.description}</:item>
        <:item title="Start time">{@outage.start_time}</:item>
        <:item title="Estimated restoration time">{@outage.estimated_restoration_time}</:item>
        <:item title="Actual restoration time">{@outage.actual_restoration_time}</:item>
        <:item title="Provider">{@outage.provider_id}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket)
      do: Ops.subscribe_outage(socket.assigns.current_scope, id)
    end

    {:ok,
      socket
      |> assign(:page_title, "Show Outage")
      |> assign(:outage, Ops.get_outage!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info({:outage_updated, outage}, socket) do
    {:noreply, assign(socket, :outage, outage)}
  end

  @impl true
  def handle_info({:outage_deleted, _outage}, socket) do
    {:noreply,
      socket
      |> put_flash(:info, "This outage has been deleted.")
      |> push_navigate(to: ~p"/outages")}
  end

  @impl true
  def handle_info({_event, _outage}, socket) do
    {:noreply, socket}
  end
end
