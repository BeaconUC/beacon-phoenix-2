defmodule Beacon.IamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Iam` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{

      })

    {:ok, profile} = Beacon.Iam.create_profile(scope, attrs)
    profile
  end
end
