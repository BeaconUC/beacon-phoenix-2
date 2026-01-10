defmodule BeaconWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use BeaconWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <header class="px-3 navbar sm:px-6 lg:px-8">
      <div class="flex-1">
        <a href="/" class="flex items-center flex-1 gap-2 w-fit">
          <img src={~p"/images/logo.svg"} width="36" />
          <span class="text-sm font-semibold">Beacon v{Application.spec(:beacon, :vsn)}</span>
        </a>
      </div>
      <div class="flex-none">
        <ul class="flex items-center px-1 space-x-4 flex-column">
          <%!-- <li>
            <a href="https://phoenixframework.org/" class="btn btn-ghost">Website</a>
          </li> --%>
          <li>
            <a href="https://github.com/phoenixframework/phoenix" class="btn btn-ghost">GitHub</a>
          </li>
          <li>
            <.theme_toggle />
          </li>
          <%!-- <li>
            <a href="https://hexdocs.pm/phoenix/overview.html" class="btn btn-primary">
              Get Started <span aria-hidden="true">&rarr;</span>
            </a>
          </li> --%>
        </ul>
      </div>
    </header>

    <main class="p-3 sm:px-6 lg:px-8">
      <div class="mx-auto space-y-4">
        {render_slot(@inner_block)}
      </div>
    </main>

    <.flash_group flash={@flash} />
    """
  end

  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true
  def admin_list(assigns) do
    ~H"""
    <div class="flex flex-col h-full overflow-hidden">
      <header class="flex-none px-3 navbar sm:px-6 lg:px-8">
        <div class="flex-1">
          <a href="/" class="flex items-center flex-1 gap-2 w-fit">
            <img src={~p"/images/logo.svg"} width="36" />
            <span class="text-sm font-semibold">Beacon v{Application.spec(:beacon, :vsn)}</span>
          </a>
        </div>
        <div class="flex-none">
          <ul class="flex items-center px-1 space-x-4">
            <li><a href="https://github.com/..." class="btn btn-ghost">GitHub</a></li>
            <li><.theme_toggle /></li>
          </ul>
        </div>
      </header>

      <main class="flex-1 min-h-0 p-3 sm:px-6 lg:px-8">
        <%!-- <div class="h-full"> --%>
          {render_slot(@inner_block)}
        <%!-- </div> --%>
      </main>

      <.flash_group flash={@flash} />
    </div>
    """
  end

  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def map(assigns) do
    ~H"""
    <main class="absolute inset-0 w-full h-full pt-12">
      {render_slot(@inner_block)}
    </main>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="relative flex flex-row items-center border-2 rounded-full card border-base-300 bg-base-300 w-24">
      <div class="absolute w-1/3 h-full rounded-full border border-base-200 bg-base-100 brightness-110
        left-0
        in-data-[selected-theme=light]:left-1/3
        in-data-[selected-theme=dark]:left-2/3
        transition-[left] duration-200 ease-in-out"
      />

      <button
        class="relative flex w-1/3 p-2 justify-center cursor-pointer z-10"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="opacity-75 size-4 hover:opacity-100" />
      </button>

      <button
        class="relative flex w-1/3 p-2 justify-center cursor-pointer z-10"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="opacity-75 size-4 hover:opacity-100" />
      </button>

      <button
        class="relative flex w-1/3 p-2 justify-center cursor-pointer z-10"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="opacity-75 size-4 hover:opacity-100" />
      </button>
    </div>
    """
end
end
