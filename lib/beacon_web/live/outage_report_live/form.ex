defmodule BeaconWeb.OutageReportLive.Form do
  use BeaconWeb, :live_view

  alias Beacon.Ops
  alias Beacon.Ops.OutageReport

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage outage_report records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="outage_report-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:description]} type="text" label="Description" />

        <%!-- 1. Status: Only visible for admins --%>
        <div :if={@profile.role == :admin}>
          <.input
            field={@form[:status]}
            type="select"
            label="Status"
            prompt="Choose a value"
            options={Ecto.Enum.values(Beacon.Ops.OutageReport, :status)}
          />
        </div>

        <%!-- 2. Geolocation: Only visible when creating (:new) --%>
        <div :if={@live_action == :new} class="space-y-2 my-5">
          <div class="flex items-center gap-4">
            <.input field={@form[:location]} type="hidden" />

            <button
              type="button"
              id="get-geo"
              phx-hook="Geolocation"
              class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-white/10 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500"
            >
              <%!-- SVG icons remain the same --%>
              <svg class="-ml-1 mr-2 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              Get Current Location
            </button>

            <div :if={Phoenix.HTML.Form.input_value(@form, :location)} class="flex items-center text-sm text-green-600 font-medium">
              <svg class="h-5 w-5 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Location captured
            </div>
          </div>
        </div>

        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Outage report</.button>
          <.button navigate={return_path(@current_scope, @return_to, @outage_report)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   <Layouts.app flash={@flash}>
  #     <.header>
  #       {@page_title}
  #       <:subtitle>Use this form to manage outage_report records in your database.</:subtitle>
  #     </.header>

  #     <.form for={@form} id="outage_report-form" phx-change="validate" phx-submit="save">
  #       <.input field={@form[:description]} type="text" label="Description" />
  #       <.input
  #         field={@form[:status]}
  #         type="select"
  #         label="Status"
  #         prompt="Choose a value"
  #         options={Ecto.Enum.values(Beacon.Ops.OutageReport, :status)}
  #       />
  #       <%!-- <div :if={@form[:location].value}>
  #         Location Set: {@form[:location].value.coordinates |> elem(1)}, {@form[:location].value.coordinates |> elem(0)}
  #       </div>
  #       <.input field={@form[:location]} type="checkbox" phx-hook="Geolocation" label="Location" /> --%>

  #       <%!-- <span>
  #         <button type="button" id="get-geo" phx-hook="Geolocation">
  #           Get Current Location
  #         </button>

  #         <p :if={Ecto.Changeset.get_field(@form.source, :location)}>
  #           📍 Location captured!
  #         </p>
  #       </span> --%>

  #       <div class="space-y-2 my-5">
  #         <div class="flex items-center gap-4">
  #           <.input field={@form[:location]} type="hidden" />

  #           <button
  #             type="button"
  #             id="get-geo"
  #             phx-hook="Geolocation"
  #             class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500"
  #           >
  #             <svg class="-ml-1 mr-2 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
  #               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
  #               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
  #             </svg>
  #             Get Current Location
  #           </button>

  #           <div :if={Phoenix.HTML.Form.input_value(@form, :location)} class="flex items-center text-sm text-green-600 font-medium">
  #             <svg class="h-5 w-5 mr-1" fill="currentColor" viewBox="0 0 20 20">
  #               <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
  #             </svg>
  #             Location captured
  #           </div>
  #         </div>
  #       </div>

  #       <%!-- <pre class="text-xs text-gray-400">
  #         Debug Location: <%= Phoenix.HTML.Form.input_value(@form, :location) |> inspect() %>
  #       </pre> --%>

  #       <footer>
  #         <.button phx-disable-with="Saving..." variant="primary">Save Outage report</.button>
  #         <.button navigate={return_path(@return_to, @outage_report)}>Cancel</.button>
  #       </footer>
  #     </.form>
  #   </Layouts.app>
  #   """
  # end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    outage_report = Ops.get_outage_report!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Outage report")
    |> assign(:outage_report, outage_report)
    |> assign(:form, to_form(Ops.change_outage_report(socket.assigns.current_scope, outage_report)))
  end

  defp apply_action(socket, :new, _params) do
    outage_report = %OutageReport{}

    socket
    |> assign(:page_title, "New Outage report")
    |> assign(:outage_report, outage_report)
    |> assign(:form, to_form(Ops.change_outage_report(socket.assigns.current_scope, outage_report)))
  end

  @impl true
  def handle_event("validate", %{"outage_report" => outage_report_params}, socket) do
    changeset = Ops.change_outage_report(socket.assigns.current_scope, socket.assigns.outage_report, outage_report_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"outage_report" => outage_report_params}, socket) do
    save_outage_report(socket, socket.assigns.live_action, outage_report_params)
  end

  # def handle_event("set_location", %{"lat" => lat, "lng" => lng}, socket) do
  #   location = %Geo.Point{coordinates: {lng, lat}, srid: 4326}

  #   # Update the form with the new location
  #   params = Map.put(socket.assigns.form.params, "location", location)
  #   changeset = OutageReport.changeset(socket.assigns.outage_report, params)

  #   {:noreply, assign(socket, form: to_form(changeset), location: location)}
  # end

  defp save_outage_report(socket, :edit, outage_report_params) do
    case Ops.update_outage_report(socket.assigns.current_scope, socket.assigns.outage_report, outage_report_params) do
      {:ok, outage_report} ->
        {:noreply,
          socket
          |> put_flash(:info, "Outage report updated successfully")
          |> push_navigate(to: return_path(socket.assigns.current_scope, socket.assigns.return_to, outage_report))}

      {:error, :unauthorized} ->
        {:noreply, put_flash(socket, :error, "You are not authorized to update this report.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_outage_report(socket, :new, outage_report_params) do
    location = socket.assigns[:location]

    case Ops.create_outage_report(socket.assigns.current_scope, outage_report_params, location) do
      {:ok, outage_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outage report created successfully")
         |> push_navigate(to: return_path(socket.assigns.current_scope, socket.assigns.return_to, outage_report))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _outage_report), do: ~p"/outage_reports"
  defp return_path(_scope, "show", outage_report), do: ~p"/outage_reports/#{outage_report}"
end
