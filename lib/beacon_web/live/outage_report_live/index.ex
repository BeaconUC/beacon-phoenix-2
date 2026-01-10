defmodule BeaconWeb.OutageReportLive.Index do
  use BeaconWeb, :live_view

  alias Beacon.Ops

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.admin_list flash={@flash} current_scope={@current_scope}>
      <%!-- <.header>
        Listing Outage reports
        <:actions>
          <.button variant="primary" navigate={~p"/outage_reports/new"}>
            <.icon name="hero-plus" /> New Outage report
          </.button>
        </:actions>
      </.header> --%>

      <%!-- <.table
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
      </.table> --%>
      <.vue
        v-component="OutageReport"
        v-socket={@socket}
        reports={@outage_reports}
        form={@form}
        v-ssr={false}
        class="h-full"
      />
    </Layouts.admin_list>
    """
  end

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
      |> assign(:page_title, "Listing Outage reports")
      |> assign(:outage_reports, list_outage_reports(socket.assigns.current_scope))
      |> assign(:form, initial_form)
    }
  end

  # @impl true
  # def mount(_params, _session, socket) do
  #   if connected?(socket) do
  #     Ops.subscribe_outage_reports(socket.assigns.current_scope)
  #   end

  #   {:ok,
  #     socket
  #     |> assign(:page_title, "Listing Outage reports")
  #     |> stream(:outage_reports, list_outage_reports(socket.assigns.current_scope))}
  # end

  @impl true
  def handle_event("edit_row", %{"id" => id}, socket) do
    report = Ops.get_outage_report!(socket.assigns.current_scope, id)
    form = Ops.change_outage_report(socket.assigns.current_scope, report)
            |> to_form(as: :outage_report)
    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    outage_report = Ops.get_outage_report!(socket.assigns.current_scope, id)

    case Ops.delete_outage_report(socket.assigns.current_scope, outage_report) do
      {:ok, _outage_report} ->
        {:noreply,
        socket
        |> put_flash(:info, "Outage report deleted successfully.")
        |> assign(:outage_reports, list_outage_reports(socket.assigns.current_scope))}

      {:error, :unauthorized} ->
        {:noreply,
        put_flash(socket, :error, "You are not authorized to delete this outage report.")}
    end
  end

  @impl true
  def handle_event("validate", %{"outage_report" => params}, socket) do
    report = Ops.get_outage_report!(socket.assigns.current_scope, params["id"])

    form =
      Ops.change_outage_report(socket.assigns.current_scope, report, params)
      |> Map.put(:action, :validate)
      |> to_form(as: :outage_report)

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"outage_report" => params}, socket) do
    report = Ops.get_outage_report!(socket.assigns.current_scope, params["id"])

    case Ops.update_outage_report(socket.assigns.current_scope, report, params) do
      {:ok, _updated} ->
        blank_form =
          Ops.change_outage_report(socket.assigns.current_scope, %Beacon.Ops.OutageReport{})
          |> to_form(as: :outage_report)

        {:noreply,
          socket
          |> put_flash(:info, "Report updated")
          |> assign(form: blank_form, outage_reports: list_outage_reports(socket.assigns.current_scope))}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset, as: :outage_report))}
    end
  end

  defp list_outage_reports(current_scope) do
    Ops.list_outage_reports(current_scope)
  end

  # def handle_info({:outage_report_deleted, outage_report}, socket) do
  #   {:noreply, stream_delete(socket, :outage_reports, outage_report)}
  # end

  # @impl true
  # def handle_info({_event, outage_report}, socket) do
  #   {:noreply, stream_insert(socket, :outage_reports, outage_report, at: 0)}
  # end

  # @impl true
  # def handle_info({:outage_report_deleted, _report}, socket) do
  #   {:noreply, assign(socket, :outage_reports, list_outage_reports(socket.assigns.current_scope))}
  # end

  @impl true
  def handle_info({_event, _report}, socket) do
    {:noreply, assign(socket, :outage_reports, list_outage_reports(socket.assigns.current_scope))}
  end
end
