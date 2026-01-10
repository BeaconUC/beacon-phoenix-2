defmodule Beacon.OpsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Ops` context.
  """

  @doc """
  Generate a outage.
  """
  def outage_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{})

    {:ok, outage} = Beacon.Ops.create_outage(scope, attrs)
    outage
  end

  @doc """
  Generate a outage_report.
  """
  def outage_report_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{})

    {:ok, outage_report} = Beacon.Ops.create_outage_report(scope, attrs)
    outage_report
  end

  @doc """
  Generate a announcement.
  """
  def announcement_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{})

    {:ok, announcement} = Beacon.Ops.create_announcement(scope, attrs)
    announcement
  end

  @doc """
  Generate a assignment.
  """
  def assignment_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{})

    {:ok, assignment} = Beacon.Ops.create_assignment(scope, attrs)
    assignment
  end
end
