defmodule BeaconWeb.OutageLive.Index do
  use BeaconWeb, :live_view

  def render(assigns) do
    ~H"""
    <LiveSvelte.svelte name="Datatable" />
    """
  end

  def handle_event("set_number", %{"number" => number}, socket) do
    {:noreply, assign(socket, :number, number)}
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # alias Beacon.Ops

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   <Layouts.app flash={@flash} current_scope={@current_scope}>
  #     <.header>
  #       Listing Outages
  #       <:actions>
  #         <.button variant="primary" navigate={~p"/outages/new"}>
  #           <.icon name="hero-plus" /> New Outage
  #         </.button>
  #       </:actions>
  #     </.header>

  #     <.table
  #       id="outages"
  #       rows={@streams.outages}
  #       row_click={fn {_id, outage} -> JS.navigate(~p"/outages/#{outage}") end}
  #     >
  #       <:col :let={{_id, outage}} label="Outage type">{outage.outage_type}</:col>
  #       <:col :let={{_id, outage}} label="Status">{outage.status}</:col>
  #       <:col :let={{_id, outage}} label="Confidence percentage">{outage.confidence_percentage}</:col>
  #       <:col :let={{_id, outage}} label="Title">{outage.title}</:col>
  #       <:col :let={{_id, outage}} label="Description">{outage.description}</:col>
  #       <:col :let={{_id, outage}} label="Start time">{outage.start_time}</:col>
  #       <:col :let={{_id, outage}} label="Estimated restoration time">
  #         {outage.estimated_restoration_time}
  #       </:col>
  #       <:col :let={{_id, outage}} label="Actual restoration time">
  #         {outage.actual_restoration_time}
  #       </:col>
  #       <:col :let={{_id, outage}} label="Provider">{outage.provider_id}</:col>
  #       <:action :let={{_id, outage}}>
  #         <div class="sr-only">
  #           <.link navigate={~p"/outages/#{outage}"}>Show</.link>
  #         </div>
  #         <.link navigate={~p"/outages/#{outage}/edit"}>Edit</.link>
  #       </:action>
  #       <:action :let={{id, outage}}>
  #         <.link
  #           phx-click={JS.push("delete", value: %{id: outage.id}) |> hide("##{id}")}
  #           data-confirm="Are you sure?"
  #         >
  #           Delete
  #         </.link>
  #       </:action>
  #     </.table>
  #   </Layouts.app>
  #   """
  # end

  # @impl true
  # def mount(_params, _session, socket) do
  #   if connected?(socket) do
  #     Ops.subscribe_outage(socket.assigns.current_scope)
  #   end

  #   {:ok,
  #    socket
  #    |> assign(:page_title, "Listing Outages")
  #    |> stream(:outages, list_outages(socket.assigns.current_scope))}
  # end

  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   outage = Ops.get_outage!(socket.assigns.current_scope, id)

  #   case Ops.delete_outage(socket.assigns.current_scope, outage) do
  #     {:ok, _outage} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Outage deleted successfully.")
  #        |> stream_delete(:outages, outage)}

  #     {:error, :unauthorized} ->
  #       {:noreply, put_flash(socket, :error, "You are not authorized to delete this outage.")}
  #   end
  # end

  # defp list_outages(current_scope) do
  #   Ops.list_outages(current_scope)
  # end

  # def handle_info({:outage_deleted, msg}, socket) do
  #   {:noreply, stream_delete(socket, :outages, msg)}
  # end

  # @impl true
  # def handle_info({_event, msg}, socket) do
  #   {:noreply, stream_insert(socket, :outages, msg, at: 0)}
  # end
end
