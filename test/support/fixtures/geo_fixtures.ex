defmodule Beacon.GeoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Geo` context.
  """

  @doc """
  Generate a region.
  """
  def region_fixture(attrs \\ %{}) do
    {:ok, region} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_region()

    region
  end

  @doc """
  Generate a province.
  """
  def province_fixture(attrs \\ %{}) do
    {:ok, province} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_province()

    province
  end

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_city()

    city
  end

  @doc """
  Generate a barangay.
  """
  def barangay_fixture(attrs \\ %{}) do
    {:ok, barangay} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_barangay()

    barangay
  end

  @doc """
  Generate a provider.
  """
  def provider_fixture(attrs \\ %{}) do
    {:ok, provider} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_provider()

    provider
  end

  @doc """
  Generate a feeder.
  """
  def feeder_fixture(attrs \\ %{}) do
    {:ok, feeder} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_feeder()

    feeder
  end

  @doc """
  Generate a barangay_feeder.
  """
  def barangay_feeder_fixture(attrs \\ %{}) do
    {:ok, barangay_feeder} =
      attrs
      |> Enum.into(%{

      })
      |> Beacon.Geo.create_barangay_feeder()

    barangay_feeder
  end
end
