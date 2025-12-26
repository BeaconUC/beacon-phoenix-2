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
      Enum.into(attrs, %{

      })

    {:ok, outage} = Beacon.Ops.create_outage(scope, attrs)
    outage
  end
end
