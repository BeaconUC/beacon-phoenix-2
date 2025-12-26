defmodule BeaconWeb.PageController do
  use BeaconWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
