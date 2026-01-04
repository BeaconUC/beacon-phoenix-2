defmodule Beacon.SysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Sys` context.
  """

  @doc """
  Generate a system_config.
  """
  def system_config_fixture(attrs \\ %{}) do
    {:ok, system_config} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Sys.create_system_config()

    system_config
  end
end
