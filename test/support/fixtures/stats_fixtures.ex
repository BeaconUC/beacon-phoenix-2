defmodule Beacon.StatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beacon.Stats` context.
  """

  @doc """
  Generate a weather_observation.
  """
  def weather_observation_fixture(attrs \\ %{}) do
    {:ok, weather_observation} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_weather_observation()

    weather_observation
  end

  @doc """
  Generate a psa_population_stat.
  """
  def psa_population_stat_fixture(attrs \\ %{}) do
    {:ok, psa_population_stat} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_psa_population_stat()

    psa_population_stat
  end

  @doc """
  Generate a psa_poverty_stat.
  """
  def psa_poverty_stat_fixture(attrs \\ %{}) do
    {:ok, psa_poverty_stat} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_psa_poverty_stat()

    psa_poverty_stat
  end

  @doc """
  Generate a psa_income_expenditure.
  """
  def psa_income_expenditure_fixture(attrs \\ %{}) do
    {:ok, psa_income_expenditure} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_psa_income_expenditure()

    psa_income_expenditure
  end

  @doc """
  Generate a psa_price_index.
  """
  def psa_price_index_fixture(attrs \\ %{}) do
    {:ok, psa_price_index} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_psa_price_index()

    psa_price_index
  end

  @doc """
  Generate a psa_economic_performance.
  """
  def psa_economic_performance_fixture(attrs \\ %{}) do
    {:ok, psa_economic_performance} =
      attrs
      |> Enum.into(%{})
      |> Beacon.Stats.create_psa_economic_performance()

    psa_economic_performance
  end
end
