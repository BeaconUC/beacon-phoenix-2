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
end
