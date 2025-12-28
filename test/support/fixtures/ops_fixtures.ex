defmodule Beacon.OpsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Ops` context.
  """

  @doc """
  Generate a outage.
  """
  def outage_fixture(attrs \\ %{}) do
    {:ok, outage} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_outage()

    outage
  end

  @doc """
  Generate a outage_update.
  """
  def outage_update_fixture(attrs \\ %{}) do
    {:ok, outage_update} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_outage_update()

    outage_update
  end

  @doc """
  Generate a outage_report.
  """
  def outage_report_fixture(attrs \\ %{}) do
    {:ok, outage_report} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_outage_report()

    outage_report
  end

  @doc """
  Generate a assignment.
  """
  def assignment_fixture(attrs \\ %{}) do
    {:ok, assignment} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_assignment()

    assignment
  end

  @doc """
  Generate a crew.
  """
  def crew_fixture(attrs \\ %{}) do
    {:ok, crew} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_crew()

    crew
  end

  @doc """
  Generate a crew_member.
  """
  def crew_member_fixture(attrs \\ %{}) do
    {:ok, crew_member} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_crew_member()

    crew_member
  end

  @doc """
  Generate a announcement.
  """
  def announcement_fixture(attrs \\ %{}) do
    {:ok, announcement} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_announcement()

    announcement
  end

  @doc """
  Generate a announcement_scope.
  """
  def announcement_scope_fixture(attrs \\ %{}) do
    {:ok, announcement_scope} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_announcement_scope()

    announcement_scope
  end

  @doc """
  Generate a affected_area.
  """
  def affected_area_fixture(attrs \\ %{}) do
    {:ok, affected_area} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Ops.create_affected_area()

    affected_area
  end
end
