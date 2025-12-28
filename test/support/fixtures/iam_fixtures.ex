defmodule Beacon.IamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Iam` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Iam.create_profile()

    profile
  end

  @doc """
  Generate a profile_setting.
  """
  def profile_setting_fixture(attrs \\ %{}) do
    {:ok, profile_setting} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Iam.create_profile_setting()

    profile_setting
  end

  @doc """
  Generate a api_key.
  """
  def api_key_fixture(attrs \\ %{}) do
    {:ok, api_key} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Iam.create_api_key()

    api_key
  end
end
