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

        <div :if={@current_scope.profile.role == :admin}>
          <.input
            field={@form[:status]}
            type="select"
            label="Status"
            prompt="Choose a value"
            options={Ecto.Enum.values(Beacon.Ops.OutageReport, :status)}
          />
        </div>

        <div :if={@live_action == :new} class="my-5 space-y-2">
          <LiveSvelte.svelte name="Geolocation" socket={@socket} />
        </div>

        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Outage report</.button>
          <.button navigate={return_path(@current_scope, @return_to, @outage_report)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

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
    |> assign(
      :form,
      to_form(Ops.change_outage_report(socket.assigns.current_scope, outage_report))
    )
  end

  defp apply_action(socket, :new, _params) do
    outage_report = %OutageReport{}

    socket
    |> assign(:page_title, "New Outage report")
    |> assign(:outage_report, outage_report)
    |> assign(
      :form,
      to_form(Ops.change_outage_report(socket.assigns.current_scope, outage_report))
    )
  end

  @impl true
  def handle_event("validate", %{"outage_report" => outage_report_params}, socket) do
    changeset =
      Ops.change_outage_report(
        socket.assigns.current_scope,
        socket.assigns.outage_report,
        outage_report_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"outage_report" => outage_report_params}, socket) do
    save_outage_report(socket, socket.assigns.live_action, outage_report_params)
  end

  def handle_event("set_location", %{"latitude" => lat, "longitude" => lng}, socket) do
    location = %Geo.Point{coordinates: {lng, lat}, srid: 4326}

    outage_report_params = socket.assigns.pending_outage_params

    case Ops.create_outage_report(
          socket.assigns.current_scope,
          outage_report_params,
          location
        ) do
      {:ok, outage_report} ->
        {:noreply,
        socket
        |> put_flash(:info, "Outage report created successfully")
        |> push_navigate(
          to: return_path(socket.assigns.current_scope, socket.assigns.return_to, outage_report)
        )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
        socket
        |> assign(:form, to_form(changeset))
        |> assign(:pending_outage_params, nil)}
      end
  end

  def handle_event("get_barangay", %{"latitude" => lat, "longitude" => lng}, socket) do
    barangay =
      Beacon.Geo.get_barangay_by_location(
        socket.assigns.current_scope,
        lat,
        lng
        # 16.4074,
        # 120.5877
      )

    payload =
      case barangay do
        nil -> %{barangay: nil}
        name -> %{barangay: name}
      end

    {:noreply, push_event(socket, "set_barangay", payload)}
  end

  defp save_outage_report(socket, :edit, outage_report_params) do
    case Ops.update_outage_report(
           socket.assigns.current_scope,
           socket.assigns.outage_report,
           outage_report_params
         ) do
      {:ok, outage_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outage report updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, outage_report)
         )}

      {:error, :unauthorized} ->
        {:noreply, put_flash(socket, :error, "You are not authorized to update this report.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_outage_report(socket, :new, outage_report_params) do
    {:noreply,
      socket
      |> assign(:pending_outage_params, outage_report_params)
      |> push_event("request_location", %{})
    }
  end

  defp return_path(_scope, "index", _outage_report), do: ~p"/outage_reports"
  defp return_path(_scope, "show", outage_report), do: ~p"/outage_reports/#{outage_report}"
end
