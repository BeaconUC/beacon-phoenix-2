defmodule BeaconWeb.OutageLive.Form do
  use BeaconWeb, :live_view

  alias Beacon.Ops
  alias Beacon.Ops.Outage

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage outage records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="outage-form" phx-change="validate" phx-submit="save">
        <.input
          field={@form[:outage_type]}
          type="select"
          label="Outage type"
          prompt="Choose a value"
          options={Ecto.Enum.values(Beacon.Ops.Outage, :outage_type)}
        />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(Beacon.Ops.Outage, :status)}
        />
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:start_time]} type="datetime-local" label="Start time" />
        <.input field={@form[:estimated_restoration_time]} type="datetime-local" label="Estimated restoration time" />
        <.input field={@form[:actual_restoration_time]} type="datetime-local" label="Actual restoration time" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Outage</.button>
          <.button navigate={return_path(@return_to, @outage)}>Cancel</.button>
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
    outage = Ops.get_outage!(id)

    socket
    |> assign(:page_title, "Edit Outage")
    |> assign(:outage, outage)
    |> assign(:form, to_form(Ops.change_outage(outage)))
  end

  defp apply_action(socket, :new, _params) do
    outage = %Outage{}

    socket
    |> assign(:page_title, "New Outage")
    |> assign(:outage, outage)
    |> assign(:form, to_form(Ops.change_outage(outage)))
  end

  @impl true
  def handle_event("validate", %{"outage" => outage_params}, socket) do
    changeset = Ops.change_outage(socket.assigns.outage, outage_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"outage" => outage_params}, socket) do
    save_outage(socket, socket.assigns.live_action, outage_params)
  end

  defp save_outage(socket, :edit, outage_params) do
    case Ops.update_outage(socket.assigns.current_scope, socket.assigns.outage, outage_params) do
      {:ok, outage} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outage updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, outage))}

      {:error, :unauthorized} ->
        {:noreply, put_flash(socket, :error, "You are not authorized to update this report.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_outage(socket, :new, outage_params) do
    case Ops.create_outage(socket.assigns.current_scope, outage_params) do
      {:ok, outage} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outage created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, outage))}

      {:error, :unauthorized} ->
        {:noreply, put_flash(socket, :error, "You are not authorized to create a report.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _outage), do: ~p"/outages"
  defp return_path("show", outage), do: ~p"/outages/#{outage}"
end
