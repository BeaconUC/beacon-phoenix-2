defmodule BeaconWeb.OutageLiveTest do
  use BeaconWeb.ConnCase

  import Phoenix.LiveViewTest
  import Beacon.OpsFixtures

  @create_attrs %{
    status: :unverified,
    description: "some description",
    title: "some title",
    outage_type: :unscheduled,
    confidence_percentage: 120.5,
    start_time: "2025-12-28T13:34:00Z",
    estimated_restoration_time: "2025-12-28T13:34:00Z",
    actual_restoration_time: "2025-12-28T13:34:00Z",
    provider_id: 42
  }
  @update_attrs %{
    status: :verified,
    description: "some updated description",
    title: "some updated title",
    outage_type: :scheduled,
    confidence_percentage: 456.7,
    start_time: "2025-12-29T13:34:00Z",
    estimated_restoration_time: "2025-12-29T13:34:00Z",
    actual_restoration_time: "2025-12-29T13:34:00Z",
    provider_id: 43
  }
  @invalid_attrs %{
    status: nil,
    description: nil,
    title: nil,
    outage_type: nil,
    confidence_percentage: nil,
    start_time: nil,
    estimated_restoration_time: nil,
    actual_restoration_time: nil,
    provider_id: nil
  }
  defp create_outage(_) do
    outage = outage_fixture()

    %{outage: outage}
  end

  describe "Index" do
    setup [:create_outage]

    test "lists all outages", %{conn: conn, outage: outage} do
      {:ok, _index_live, html} = live(conn, ~p"/outages")

      assert html =~ "Listing Outages"
      assert html =~ outage.title
    end

    test "saves new outage", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/outages")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Outage")
               |> render_click()
               |> follow_redirect(conn, ~p"/outages/new")

      assert render(form_live) =~ "New Outage"

      assert form_live
             |> form("#outage-form", outage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#outage-form", outage: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outages")

      html = render(index_live)
      assert html =~ "Outage created successfully"
      assert html =~ "some title"
    end

    test "updates outage in listing", %{conn: conn, outage: outage} do
      {:ok, index_live, _html} = live(conn, ~p"/outages")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#outages-#{outage.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/outages/#{outage}/edit")

      assert render(form_live) =~ "Edit Outage"

      assert form_live
             |> form("#outage-form", outage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#outage-form", outage: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outages")

      html = render(index_live)
      assert html =~ "Outage updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes outage in listing", %{conn: conn, outage: outage} do
      {:ok, index_live, _html} = live(conn, ~p"/outages")

      assert index_live |> element("#outages-#{outage.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#outages-#{outage.id}")
    end
  end

  describe "Show" do
    setup [:create_outage]

    test "displays outage", %{conn: conn, outage: outage} do
      {:ok, _show_live, html} = live(conn, ~p"/outages/#{outage}")

      assert html =~ "Show Outage"
      assert html =~ outage.title
    end

    test "updates outage and returns to show", %{conn: conn, outage: outage} do
      {:ok, show_live, _html} = live(conn, ~p"/outages/#{outage}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/outages/#{outage}/edit?return_to=show")

      assert render(form_live) =~ "Edit Outage"

      assert form_live
             |> form("#outage-form", outage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#outage-form", outage: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outages/#{outage}")

      html = render(show_live)
      assert html =~ "Outage updated successfully"
      assert html =~ "some updated title"
    end
  end
end
