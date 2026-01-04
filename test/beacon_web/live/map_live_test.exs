defmodule BeaconWeb.MapLiveTest do
  use BeaconWeb.ConnCase

  import Phoenix.LiveViewTest
  import Beacon.MapsFixtures

  @create_attrs %{dummy: "some dummy"}
  @update_attrs %{dummy: "some updated dummy"}
  @invalid_attrs %{dummy: nil}

  setup :register_and_log_in_user

  defp create_map(%{scope: scope}) do
    map = map_fixture(scope)

    %{map: map}
  end

  describe "Index" do
    setup [:create_map]

    test "lists all maps", %{conn: conn, map: map} do
      {:ok, _index_live, html} = live(conn, ~p"/maps")

      assert html =~ "Listing Maps"
      assert html =~ map.dummy
    end

    test "saves new map", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Map")
               |> render_click()
               |> follow_redirect(conn, ~p"/maps/new")

      assert render(form_live) =~ "New Map"

      assert form_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#map-form", map: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/maps")

      html = render(index_live)
      assert html =~ "Map created successfully"
      assert html =~ "some dummy"
    end

    test "updates map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#maps-#{map.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/maps/#{map}/edit")

      assert render(form_live) =~ "Edit Map"

      assert form_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#map-form", map: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/maps")

      html = render(index_live)
      assert html =~ "Map updated successfully"
      assert html =~ "some updated dummy"
    end

    test "deletes map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/maps")

      assert index_live |> element("#maps-#{map.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#maps-#{map.id}")
    end
  end

  describe "Show" do
    setup [:create_map]

    test "displays map", %{conn: conn, map: map} do
      {:ok, _show_live, html} = live(conn, ~p"/maps/#{map}")

      assert html =~ "Show Map"
      assert html =~ map.dummy
    end

    test "updates map and returns to show", %{conn: conn, map: map} do
      {:ok, show_live, _html} = live(conn, ~p"/maps/#{map}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/maps/#{map}/edit?return_to=show")

      assert render(form_live) =~ "Edit Map"

      assert form_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#map-form", map: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/maps/#{map}")

      html = render(show_live)
      assert html =~ "Map updated successfully"
      assert html =~ "some updated dummy"
    end
  end
end
