defmodule Beacon.OpsTest do
  use Beacon.DataCase

  alias Beacon.Ops

  describe "outages" do
    alias Beacon.Ops.Outage

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outages/1 returns all scoped outages" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)
      other_outage = outage_fixture(other_scope)
      assert Ops.list_outages(scope) == [outage]
      assert Ops.list_outages(other_scope) == [other_outage]
    end

    test "get_outage!/2 returns the outage with given id" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      other_scope = user_scope_fixture()
      assert Ops.get_outage!(scope, outage.id) == outage
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(other_scope, outage.id) end
    end

    test "create_outage/2 with valid data creates a outage" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %Outage{} = outage} = Ops.create_outage(scope, valid_attrs)
      assert outage.user_id == scope.user.id
    end

    test "create_outage/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage(scope, @invalid_attrs)
    end

    test "update_outage/3 with valid data updates the outage" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      update_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.update_outage(scope, outage, update_attrs)
    end

    test "update_outage/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)

      assert_raise MatchError, fn ->
        Ops.update_outage(other_scope, outage, %{})
      end
    end

    test "update_outage/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage(scope, outage, @invalid_attrs)
      assert outage == Ops.get_outage!(scope, outage.id)
    end

    test "delete_outage/2 deletes the outage" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert {:ok, %Outage{}} = Ops.delete_outage(scope, outage)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(scope, outage.id) end
    end

    test "delete_outage/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert_raise MatchError, fn -> Ops.delete_outage(other_scope, outage) end
    end

    test "change_outage/2 returns a outage changeset" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert %Ecto.Changeset{} = Ops.change_outage(scope, outage)
    end
  end

  describe "outage_reports" do
    alias Beacon.Ops.OutageReport

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outage_reports/1 returns all scoped outage_reports" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      other_outage_report = outage_report_fixture(other_scope)
      assert Ops.list_outage_reports(scope) == [outage_report]
      assert Ops.list_outage_reports(other_scope) == [other_outage_report]
    end

    test "get_outage_report!/2 returns the outage_report with given id" do
      scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      other_scope = user_scope_fixture()
      assert Ops.get_outage_report!(scope, outage_report.id) == outage_report
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage_report!(other_scope, outage_report.id) end
    end

    test "create_outage_report/2 with valid data creates a outage_report" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %OutageReport{} = outage_report} = Ops.create_outage_report(scope, valid_attrs)
      assert outage_report.user_id == scope.user.id
    end

    test "create_outage_report/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage_report(scope, @invalid_attrs)
    end

    test "update_outage_report/3 with valid data updates the outage_report" do
      scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      update_attrs = %{}

      assert {:ok, %OutageReport{} = outage_report} = Ops.update_outage_report(scope, outage_report, update_attrs)
    end

    test "update_outage_report/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)

      assert_raise MatchError, fn ->
        Ops.update_outage_report(other_scope, outage_report, %{})
      end
    end

    test "update_outage_report/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage_report(scope, outage_report, @invalid_attrs)
      assert outage_report == Ops.get_outage_report!(scope, outage_report.id)
    end

    test "delete_outage_report/2 deletes the outage_report" do
      scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      assert {:ok, %OutageReport{}} = Ops.delete_outage_report(scope, outage_report)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage_report!(scope, outage_report.id) end
    end

    test "delete_outage_report/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      assert_raise MatchError, fn -> Ops.delete_outage_report(other_scope, outage_report) end
    end

    test "change_outage_report/2 returns a outage_report changeset" do
      scope = user_scope_fixture()
      outage_report = outage_report_fixture(scope)
      assert %Ecto.Changeset{} = Ops.change_outage_report(scope, outage_report)
    end
  end

  describe "announcements" do
    alias Beacon.Ops.Announcement

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_announcements/1 returns all scoped announcements" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      other_announcement = announcement_fixture(other_scope)
      assert Ops.list_announcements(scope) == [announcement]
      assert Ops.list_announcements(other_scope) == [other_announcement]
    end

    test "get_announcement!/2 returns the announcement with given id" do
      scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      other_scope = user_scope_fixture()
      assert Ops.get_announcement!(scope, announcement.id) == announcement
      assert_raise Ecto.NoResultsError, fn -> Ops.get_announcement!(other_scope, announcement.id) end
    end

    test "create_announcement/2 with valid data creates a announcement" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %Announcement{} = announcement} = Ops.create_announcement(scope, valid_attrs)
      assert announcement.user_id == scope.user.id
    end

    test "create_announcement/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.create_announcement(scope, @invalid_attrs)
    end

    test "update_announcement/3 with valid data updates the announcement" do
      scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      update_attrs = %{}

      assert {:ok, %Announcement{} = announcement} = Ops.update_announcement(scope, announcement, update_attrs)
    end

    test "update_announcement/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      announcement = announcement_fixture(scope)

      assert_raise MatchError, fn ->
        Ops.update_announcement(other_scope, announcement, %{})
      end
    end

    test "update_announcement/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Ops.update_announcement(scope, announcement, @invalid_attrs)
      assert announcement == Ops.get_announcement!(scope, announcement.id)
    end

    test "delete_announcement/2 deletes the announcement" do
      scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      assert {:ok, %Announcement{}} = Ops.delete_announcement(scope, announcement)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_announcement!(scope, announcement.id) end
    end

    test "delete_announcement/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      assert_raise MatchError, fn -> Ops.delete_announcement(other_scope, announcement) end
    end

    test "change_announcement/2 returns a announcement changeset" do
      scope = user_scope_fixture()
      announcement = announcement_fixture(scope)
      assert %Ecto.Changeset{} = Ops.change_announcement(scope, announcement)
    end
  end

  describe "assignments" do
    alias Beacon.Ops.Assignment

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_assignments/1 returns all scoped assignments" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      other_assignment = assignment_fixture(other_scope)
      assert Ops.list_assignments(scope) == [assignment]
      assert Ops.list_assignments(other_scope) == [other_assignment]
    end

    test "get_assignment!/2 returns the assignment with given id" do
      scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      other_scope = user_scope_fixture()
      assert Ops.get_assignment!(scope, assignment.id) == assignment
      assert_raise Ecto.NoResultsError, fn -> Ops.get_assignment!(other_scope, assignment.id) end
    end

    test "create_assignment/2 with valid data creates a assignment" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %Assignment{} = assignment} = Ops.create_assignment(scope, valid_attrs)
      assert assignment.user_id == scope.user.id
    end

    test "create_assignment/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.create_assignment(scope, @invalid_attrs)
    end

    test "update_assignment/3 with valid data updates the assignment" do
      scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      update_attrs = %{}

      assert {:ok, %Assignment{} = assignment} = Ops.update_assignment(scope, assignment, update_attrs)
    end

    test "update_assignment/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      assignment = assignment_fixture(scope)

      assert_raise MatchError, fn ->
        Ops.update_assignment(other_scope, assignment, %{})
      end
    end

    test "update_assignment/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Ops.update_assignment(scope, assignment, @invalid_attrs)
      assert assignment == Ops.get_assignment!(scope, assignment.id)
    end

    test "delete_assignment/2 deletes the assignment" do
      scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      assert {:ok, %Assignment{}} = Ops.delete_assignment(scope, assignment)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_assignment!(scope, assignment.id) end
    end

    test "delete_assignment/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      assert_raise MatchError, fn -> Ops.delete_assignment(other_scope, assignment) end
    end

    test "change_assignment/2 returns a assignment changeset" do
      scope = user_scope_fixture()
      assignment = assignment_fixture(scope)
      assert %Ecto.Changeset{} = Ops.change_assignment(scope, assignment)
    end
  end
end
