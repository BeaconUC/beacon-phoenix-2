defmodule Beacon.OpsTest do
  use Beacon.DataCase

  alias Beacon.Ops

  describe "outages" do
    alias Beacon.Ops.Outage

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outages/0 returns all outages" do
      outage = outage_fixture()
      assert Ops.list_outages() == [outage]
    end

    test "get_outage!/1 returns the outage with given id" do
      outage = outage_fixture()
      assert Ops.get_outage!(outage.id) == outage
    end

    test "create_outage/1 with valid data creates a outage" do
      valid_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.create_outage(valid_attrs)
    end

    test "create_outage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage(@invalid_attrs)
    end

    test "update_outage/2 with valid data updates the outage" do
      outage = outage_fixture()
      update_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.update_outage(outage, update_attrs)
    end

    test "update_outage/2 with invalid data returns error changeset" do
      outage = outage_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage(outage, @invalid_attrs)
      assert outage == Ops.get_outage!(outage.id)
    end

    test "delete_outage/1 deletes the outage" do
      outage = outage_fixture()
      assert {:ok, %Outage{}} = Ops.delete_outage(outage)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(outage.id) end
    end

    test "change_outage/1 returns a outage changeset" do
      outage = outage_fixture()
      assert %Ecto.Changeset{} = Ops.change_outage(outage)
    end
  end

  describe "outage_updates" do
    alias Beacon.Ops.OutageUpdate

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outage_updates/0 returns all outage_updates" do
      outage_update = outage_update_fixture()
      assert Ops.list_outage_updates() == [outage_update]
    end

    test "get_outage_update!/1 returns the outage_update with given id" do
      outage_update = outage_update_fixture()
      assert Ops.get_outage_update!(outage_update.id) == outage_update
    end

    test "create_outage_update/1 with valid data creates a outage_update" do
      valid_attrs = %{}

      assert {:ok, %OutageUpdate{} = outage_update} = Ops.create_outage_update(valid_attrs)
    end

    test "create_outage_update/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage_update(@invalid_attrs)
    end

    test "update_outage_update/2 with valid data updates the outage_update" do
      outage_update = outage_update_fixture()
      update_attrs = %{}

      assert {:ok, %OutageUpdate{} = outage_update} = Ops.update_outage_update(outage_update, update_attrs)
    end

    test "update_outage_update/2 with invalid data returns error changeset" do
      outage_update = outage_update_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage_update(outage_update, @invalid_attrs)
      assert outage_update == Ops.get_outage_update!(outage_update.id)
    end

    test "delete_outage_update/1 deletes the outage_update" do
      outage_update = outage_update_fixture()
      assert {:ok, %OutageUpdate{}} = Ops.delete_outage_update(outage_update)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage_update!(outage_update.id) end
    end

    test "change_outage_update/1 returns a outage_update changeset" do
      outage_update = outage_update_fixture()
      assert %Ecto.Changeset{} = Ops.change_outage_update(outage_update)
    end
  end

  describe "outage_reports" do
    alias Beacon.Ops.OutageReport

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outage_reports/0 returns all outage_reports" do
      outage_report = outage_report_fixture()
      assert Ops.list_outage_reports() == [outage_report]
    end

    test "get_outage_report!/1 returns the outage_report with given id" do
      outage_report = outage_report_fixture()
      assert Ops.get_outage_report!(outage_report.id) == outage_report
    end

    test "create_outage_report/1 with valid data creates a outage_report" do
      valid_attrs = %{}

      assert {:ok, %OutageReport{} = outage_report} = Ops.create_outage_report(valid_attrs)
    end

    test "create_outage_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage_report(@invalid_attrs)
    end

    test "update_outage_report/2 with valid data updates the outage_report" do
      outage_report = outage_report_fixture()
      update_attrs = %{}

      assert {:ok, %OutageReport{} = outage_report} = Ops.update_outage_report(outage_report, update_attrs)
    end

    test "update_outage_report/2 with invalid data returns error changeset" do
      outage_report = outage_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage_report(outage_report, @invalid_attrs)
      assert outage_report == Ops.get_outage_report!(outage_report.id)
    end

    test "delete_outage_report/1 deletes the outage_report" do
      outage_report = outage_report_fixture()
      assert {:ok, %OutageReport{}} = Ops.delete_outage_report(outage_report)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage_report!(outage_report.id) end
    end

    test "change_outage_report/1 returns a outage_report changeset" do
      outage_report = outage_report_fixture()
      assert %Ecto.Changeset{} = Ops.change_outage_report(outage_report)
    end
  end

  describe "assignments" do
    alias Beacon.Ops.Assignment

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_assignments/0 returns all assignments" do
      assignment = assignment_fixture()
      assert Ops.list_assignments() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert Ops.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      valid_attrs = %{}

      assert {:ok, %Assignment{} = assignment} = Ops.create_assignment(valid_attrs)
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()
      update_attrs = %{}

      assert {:ok, %Assignment{} = assignment} = Ops.update_assignment(assignment, update_attrs)
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_assignment(assignment, @invalid_attrs)
      assert assignment == Ops.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = Ops.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = Ops.change_assignment(assignment)
    end
  end

  describe "crews" do
    alias Beacon.Ops.Crew

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_crews/0 returns all crews" do
      crew = crew_fixture()
      assert Ops.list_crews() == [crew]
    end

    test "get_crew!/1 returns the crew with given id" do
      crew = crew_fixture()
      assert Ops.get_crew!(crew.id) == crew
    end

    test "create_crew/1 with valid data creates a crew" do
      valid_attrs = %{}

      assert {:ok, %Crew{} = crew} = Ops.create_crew(valid_attrs)
    end

    test "create_crew/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_crew(@invalid_attrs)
    end

    test "update_crew/2 with valid data updates the crew" do
      crew = crew_fixture()
      update_attrs = %{}

      assert {:ok, %Crew{} = crew} = Ops.update_crew(crew, update_attrs)
    end

    test "update_crew/2 with invalid data returns error changeset" do
      crew = crew_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_crew(crew, @invalid_attrs)
      assert crew == Ops.get_crew!(crew.id)
    end

    test "delete_crew/1 deletes the crew" do
      crew = crew_fixture()
      assert {:ok, %Crew{}} = Ops.delete_crew(crew)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_crew!(crew.id) end
    end

    test "change_crew/1 returns a crew changeset" do
      crew = crew_fixture()
      assert %Ecto.Changeset{} = Ops.change_crew(crew)
    end
  end

  describe "crew_members" do
    alias Beacon.Ops.CrewMember

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_crew_members/0 returns all crew_members" do
      crew_member = crew_member_fixture()
      assert Ops.list_crew_members() == [crew_member]
    end

    test "get_crew_member!/1 returns the crew_member with given id" do
      crew_member = crew_member_fixture()
      assert Ops.get_crew_member!(crew_member.id) == crew_member
    end

    test "create_crew_member/1 with valid data creates a crew_member" do
      valid_attrs = %{}

      assert {:ok, %CrewMember{} = crew_member} = Ops.create_crew_member(valid_attrs)
    end

    test "create_crew_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_crew_member(@invalid_attrs)
    end

    test "update_crew_member/2 with valid data updates the crew_member" do
      crew_member = crew_member_fixture()
      update_attrs = %{}

      assert {:ok, %CrewMember{} = crew_member} = Ops.update_crew_member(crew_member, update_attrs)
    end

    test "update_crew_member/2 with invalid data returns error changeset" do
      crew_member = crew_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_crew_member(crew_member, @invalid_attrs)
      assert crew_member == Ops.get_crew_member!(crew_member.id)
    end

    test "delete_crew_member/1 deletes the crew_member" do
      crew_member = crew_member_fixture()
      assert {:ok, %CrewMember{}} = Ops.delete_crew_member(crew_member)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_crew_member!(crew_member.id) end
    end

    test "change_crew_member/1 returns a crew_member changeset" do
      crew_member = crew_member_fixture()
      assert %Ecto.Changeset{} = Ops.change_crew_member(crew_member)
    end
  end

  describe "announcements" do
    alias Beacon.Ops.Announcement

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_announcements/0 returns all announcements" do
      announcement = announcement_fixture()
      assert Ops.list_announcements() == [announcement]
    end

    test "get_announcement!/1 returns the announcement with given id" do
      announcement = announcement_fixture()
      assert Ops.get_announcement!(announcement.id) == announcement
    end

    test "create_announcement/1 with valid data creates a announcement" do
      valid_attrs = %{}

      assert {:ok, %Announcement{} = announcement} = Ops.create_announcement(valid_attrs)
    end

    test "create_announcement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_announcement(@invalid_attrs)
    end

    test "update_announcement/2 with valid data updates the announcement" do
      announcement = announcement_fixture()
      update_attrs = %{}

      assert {:ok, %Announcement{} = announcement} = Ops.update_announcement(announcement, update_attrs)
    end

    test "update_announcement/2 with invalid data returns error changeset" do
      announcement = announcement_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_announcement(announcement, @invalid_attrs)
      assert announcement == Ops.get_announcement!(announcement.id)
    end

    test "delete_announcement/1 deletes the announcement" do
      announcement = announcement_fixture()
      assert {:ok, %Announcement{}} = Ops.delete_announcement(announcement)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_announcement!(announcement.id) end
    end

    test "change_announcement/1 returns a announcement changeset" do
      announcement = announcement_fixture()
      assert %Ecto.Changeset{} = Ops.change_announcement(announcement)
    end
  end

  describe "announcement_scopes" do
    alias Beacon.Ops.AnnouncementScope

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_announcement_scopes/0 returns all announcement_scopes" do
      announcement_scope = announcement_scope_fixture()
      assert Ops.list_announcement_scopes() == [announcement_scope]
    end

    test "get_announcement_scope!/1 returns the announcement_scope with given id" do
      announcement_scope = announcement_scope_fixture()
      assert Ops.get_announcement_scope!(announcement_scope.id) == announcement_scope
    end

    test "create_announcement_scope/1 with valid data creates a announcement_scope" do
      valid_attrs = %{}

      assert {:ok, %AnnouncementScope{} = announcement_scope} = Ops.create_announcement_scope(valid_attrs)
    end

    test "create_announcement_scope/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_announcement_scope(@invalid_attrs)
    end

    test "update_announcement_scope/2 with valid data updates the announcement_scope" do
      announcement_scope = announcement_scope_fixture()
      update_attrs = %{}

      assert {:ok, %AnnouncementScope{} = announcement_scope} = Ops.update_announcement_scope(announcement_scope, update_attrs)
    end

    test "update_announcement_scope/2 with invalid data returns error changeset" do
      announcement_scope = announcement_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_announcement_scope(announcement_scope, @invalid_attrs)
      assert announcement_scope == Ops.get_announcement_scope!(announcement_scope.id)
    end

    test "delete_announcement_scope/1 deletes the announcement_scope" do
      announcement_scope = announcement_scope_fixture()
      assert {:ok, %AnnouncementScope{}} = Ops.delete_announcement_scope(announcement_scope)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_announcement_scope!(announcement_scope.id) end
    end

    test "change_announcement_scope/1 returns a announcement_scope changeset" do
      announcement_scope = announcement_scope_fixture()
      assert %Ecto.Changeset{} = Ops.change_announcement_scope(announcement_scope)
    end
  end

  describe "affected_areas" do
    alias Beacon.Ops.AffectedArea

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_affected_areas/0 returns all affected_areas" do
      affected_area = affected_area_fixture()
      assert Ops.list_affected_areas() == [affected_area]
    end

    test "get_affected_area!/1 returns the affected_area with given id" do
      affected_area = affected_area_fixture()
      assert Ops.get_affected_area!(affected_area.id) == affected_area
    end

    test "create_affected_area/1 with valid data creates a affected_area" do
      valid_attrs = %{}

      assert {:ok, %AffectedArea{} = affected_area} = Ops.create_affected_area(valid_attrs)
    end

    test "create_affected_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_affected_area(@invalid_attrs)
    end

    test "update_affected_area/2 with valid data updates the affected_area" do
      affected_area = affected_area_fixture()
      update_attrs = %{}

      assert {:ok, %AffectedArea{} = affected_area} = Ops.update_affected_area(affected_area, update_attrs)
    end

    test "update_affected_area/2 with invalid data returns error changeset" do
      affected_area = affected_area_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_affected_area(affected_area, @invalid_attrs)
      assert affected_area == Ops.get_affected_area!(affected_area.id)
    end

    test "delete_affected_area/1 deletes the affected_area" do
      affected_area = affected_area_fixture()
      assert {:ok, %AffectedArea{}} = Ops.delete_affected_area(affected_area)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_affected_area!(affected_area.id) end
    end

    test "change_affected_area/1 returns a affected_area changeset" do
      affected_area = affected_area_fixture()
      assert %Ecto.Changeset{} = Ops.change_affected_area(affected_area)
    end
  end
end
