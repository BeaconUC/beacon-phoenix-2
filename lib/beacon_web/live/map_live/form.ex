defmodule BeaconWeb.MapLive.Form do
  use BeaconWeb, :live_view

  alias Beacon.Maps
  alias Beacon.Maps.Map

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage map records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="map-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:dummy]} type="text" label="Dummy" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Map</.button>
          <.button navigate={return_path(@current_scope, @return_to, @map)}>Cancel</.button>
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
    map = Maps.get_map!(socket.assigns.current_scope, id)

    socket
    |> assign(:page_title, "Edit Map")
    |> assign(:map, map)
    |> assign(:form, to_form(Maps.change_map(socket.assigns.current_scope, map)))
  end

  defp apply_action(socket, :new, _params) do
    map = %Map{user_id: socket.assigns.current_scope.user.id}

    socket
    |> assign(:page_title, "New Map")
    |> assign(:map, map)
    |> assign(:form, to_form(Maps.change_map(socket.assigns.current_scope, map)))
  end

  @impl true
  def handle_event("validate", %{"map" => map_params}, socket) do
    changeset = Maps.change_map(socket.assigns.current_scope, socket.assigns.map, map_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"map" => map_params}, socket) do
    save_map(socket, socket.assigns.live_action, map_params)
  end

  defp save_map(socket, :edit, map_params) do
    case Maps.update_map(socket.assigns.current_scope, socket.assigns.map, map_params) do
      {:ok, map} ->
        {:noreply,
         socket
         |> put_flash(:info, "Map updated successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, map)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_map(socket, :new, map_params) do
    case Maps.create_map(socket.assigns.current_scope, map_params) do
      {:ok, map} ->
        {:noreply,
         socket
         |> put_flash(:info, "Map created successfully")
         |> push_navigate(
           to: return_path(socket.assigns.current_scope, socket.assigns.return_to, map)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path(_scope, "index", _map), do: ~p"/maps"
  defp return_path(_scope, "show", map), do: ~p"/maps/#{map}"
end
