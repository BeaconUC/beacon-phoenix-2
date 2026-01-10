defmodule BeaconWeb.OutageReportLiveTest do
  use BeaconWeb.ConnCase

  import Phoenix.LiveViewTest
  import Beacon.OpsFixtures

  @create_attrs %{status: :unprocessed, description: "some description"}
  @update_attrs %{status: :processed_as_part_of_outage, description: "some updated description"}
  @invalid_attrs %{status: nil, description: nil}
  defp create_outage_report(_) do
    outage_report = outage_report_fixture()

    %{outage_report: outage_report}
  end

  describe "Index" do
    setup [:create_outage_report]

    test "lists all outage_reports", %{conn: conn, outage_report: outage_report} do
      {:ok, _index_live, html} = live(conn, ~p"/outage_reports")

      assert html =~ "Listing Outage reports"
      assert html =~ outage_report.description
    end

    test "saves new outage_report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/outage_reports")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Outage report")
               |> render_click()
               |> follow_redirect(conn, ~p"/outage_reports/new")

      assert render(form_live) =~ "New Outage report"

      assert form_live
             |> form("#outage_report-form", outage_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#outage_report-form", outage_report: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outage_reports")

      html = render(index_live)
      assert html =~ "Outage report created successfully"
      assert html =~ "some description"
    end

    test "updates outage_report in listing", %{conn: conn, outage_report: outage_report} do
      {:ok, index_live, _html} = live(conn, ~p"/outage_reports")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#outage_reports-#{outage_report.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/outage_reports/#{outage_report}/edit")

      assert render(form_live) =~ "Edit Outage report"

      assert form_live
             |> form("#outage_report-form", outage_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#outage_report-form", outage_report: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outage_reports")

      html = render(index_live)
      assert html =~ "Outage report updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes outage_report in listing", %{conn: conn, outage_report: outage_report} do
      {:ok, index_live, _html} = live(conn, ~p"/outage_reports")

      assert index_live
             |> element("#outage_reports-#{outage_report.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#outage_reports-#{outage_report.id}")
    end
  end

  describe "Show" do
    setup [:create_outage_report]

    test "displays outage_report", %{conn: conn, outage_report: outage_report} do
      {:ok, _show_live, html} = live(conn, ~p"/outage_reports/#{outage_report}")

      assert html =~ "Show Outage report"
      assert html =~ outage_report.description
    end

    test "updates outage_report and returns to show", %{conn: conn, outage_report: outage_report} do
      {:ok, show_live, _html} = live(conn, ~p"/outage_reports/#{outage_report}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/outage_reports/#{outage_report}/edit?return_to=show")

      assert render(form_live) =~ "Edit Outage report"

      assert form_live
             |> form("#outage_report-form", outage_report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#outage_report-form", outage_report: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/outage_reports/#{outage_report}")

      html = render(show_live)
      assert html =~ "Outage report updated successfully"
      assert html =~ "some updated description"
    end
  end
end
