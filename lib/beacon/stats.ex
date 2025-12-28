defmodule Beacon.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Stats.WeatherObservation

  @doc """
  Returns the list of weather_observations.

  ## Examples

      iex> list_weather_observations()
      [%WeatherObservation{}, ...]

  """
  def list_weather_observations do
    Repo.all(WeatherObservation)
  end

  @doc """
  Gets a single weather_observation.

  Raises `Ecto.NoResultsError` if the Weather observation does not exist.

  ## Examples

      iex> get_weather_observation!(123)
      %WeatherObservation{}

      iex> get_weather_observation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weather_observation!(id), do: Repo.get!(WeatherObservation, id)

  @doc """
  Creates a weather_observation.

  ## Examples

      iex> create_weather_observation(%{field: value})
      {:ok, %WeatherObservation{}}

      iex> create_weather_observation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_weather_observation(attrs) do
    %WeatherObservation{}
    |> WeatherObservation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weather_observation.

  ## Examples

      iex> update_weather_observation(weather_observation, %{field: new_value})
      {:ok, %WeatherObservation{}}

      iex> update_weather_observation(weather_observation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weather_observation(%WeatherObservation{} = weather_observation, attrs) do
    weather_observation
    |> WeatherObservation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weather_observation.

  ## Examples

      iex> delete_weather_observation(weather_observation)
      {:ok, %WeatherObservation{}}

      iex> delete_weather_observation(weather_observation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weather_observation(%WeatherObservation{} = weather_observation) do
    Repo.delete(weather_observation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weather_observation changes.

  ## Examples

      iex> change_weather_observation(weather_observation)
      %Ecto.Changeset{data: %WeatherObservation{}}

  """
  def change_weather_observation(%WeatherObservation{} = weather_observation, attrs \\ %{}) do
    WeatherObservation.changeset(weather_observation, attrs)
  end

  alias Beacon.Stats.PsaPopulationStat

  @doc """
  Returns the list of psa_population_stats.

  ## Examples

      iex> list_psa_population_stats()
      [%PsaPopulationStat{}, ...]

  """
  def list_psa_population_stats do
    Repo.all(PsaPopulationStat)
  end

  @doc """
  Gets a single psa_population_stat.

  Raises `Ecto.NoResultsError` if the Psa population stat does not exist.

  ## Examples

      iex> get_psa_population_stat!(123)
      %PsaPopulationStat{}

      iex> get_psa_population_stat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psa_population_stat!(id), do: Repo.get!(PsaPopulationStat, id)

  @doc """
  Creates a psa_population_stat.

  ## Examples

      iex> create_psa_population_stat(%{field: value})
      {:ok, %PsaPopulationStat{}}

      iex> create_psa_population_stat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psa_population_stat(attrs) do
    %PsaPopulationStat{}
    |> PsaPopulationStat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psa_population_stat.

  ## Examples

      iex> update_psa_population_stat(psa_population_stat, %{field: new_value})
      {:ok, %PsaPopulationStat{}}

      iex> update_psa_population_stat(psa_population_stat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psa_population_stat(%PsaPopulationStat{} = psa_population_stat, attrs) do
    psa_population_stat
    |> PsaPopulationStat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psa_population_stat.

  ## Examples

      iex> delete_psa_population_stat(psa_population_stat)
      {:ok, %PsaPopulationStat{}}

      iex> delete_psa_population_stat(psa_population_stat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psa_population_stat(%PsaPopulationStat{} = psa_population_stat) do
    Repo.delete(psa_population_stat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psa_population_stat changes.

  ## Examples

      iex> change_psa_population_stat(psa_population_stat)
      %Ecto.Changeset{data: %PsaPopulationStat{}}

  """
  def change_psa_population_stat(%PsaPopulationStat{} = psa_population_stat, attrs \\ %{}) do
    PsaPopulationStat.changeset(psa_population_stat, attrs)
  end

  alias Beacon.Stats.PsaPovertyStat

  @doc """
  Returns the list of psa_poverty_stats.

  ## Examples

      iex> list_psa_poverty_stats()
      [%PsaPovertyStat{}, ...]

  """
  def list_psa_poverty_stats do
    Repo.all(PsaPovertyStat)
  end

  @doc """
  Gets a single psa_poverty_stat.

  Raises `Ecto.NoResultsError` if the Psa poverty stat does not exist.

  ## Examples

      iex> get_psa_poverty_stat!(123)
      %PsaPovertyStat{}

      iex> get_psa_poverty_stat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psa_poverty_stat!(id), do: Repo.get!(PsaPovertyStat, id)

  @doc """
  Creates a psa_poverty_stat.

  ## Examples

      iex> create_psa_poverty_stat(%{field: value})
      {:ok, %PsaPovertyStat{}}

      iex> create_psa_poverty_stat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psa_poverty_stat(attrs) do
    %PsaPovertyStat{}
    |> PsaPovertyStat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psa_poverty_stat.

  ## Examples

      iex> update_psa_poverty_stat(psa_poverty_stat, %{field: new_value})
      {:ok, %PsaPovertyStat{}}

      iex> update_psa_poverty_stat(psa_poverty_stat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psa_poverty_stat(%PsaPovertyStat{} = psa_poverty_stat, attrs) do
    psa_poverty_stat
    |> PsaPovertyStat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psa_poverty_stat.

  ## Examples

      iex> delete_psa_poverty_stat(psa_poverty_stat)
      {:ok, %PsaPovertyStat{}}

      iex> delete_psa_poverty_stat(psa_poverty_stat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psa_poverty_stat(%PsaPovertyStat{} = psa_poverty_stat) do
    Repo.delete(psa_poverty_stat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psa_poverty_stat changes.

  ## Examples

      iex> change_psa_poverty_stat(psa_poverty_stat)
      %Ecto.Changeset{data: %PsaPovertyStat{}}

  """
  def change_psa_poverty_stat(%PsaPovertyStat{} = psa_poverty_stat, attrs \\ %{}) do
    PsaPovertyStat.changeset(psa_poverty_stat, attrs)
  end

  alias Beacon.Stats.PsaIncomeExpenditure

  @doc """
  Returns the list of psa_income_expenditures.

  ## Examples

      iex> list_psa_income_expenditures()
      [%PsaIncomeExpenditure{}, ...]

  """
  def list_psa_income_expenditures do
    Repo.all(PsaIncomeExpenditure)
  end

  @doc """
  Gets a single psa_income_expenditure.

  Raises `Ecto.NoResultsError` if the Psa income expenditure does not exist.

  ## Examples

      iex> get_psa_income_expenditure!(123)
      %PsaIncomeExpenditure{}

      iex> get_psa_income_expenditure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psa_income_expenditure!(id), do: Repo.get!(PsaIncomeExpenditure, id)

  @doc """
  Creates a psa_income_expenditure.

  ## Examples

      iex> create_psa_income_expenditure(%{field: value})
      {:ok, %PsaIncomeExpenditure{}}

      iex> create_psa_income_expenditure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psa_income_expenditure(attrs) do
    %PsaIncomeExpenditure{}
    |> PsaIncomeExpenditure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psa_income_expenditure.

  ## Examples

      iex> update_psa_income_expenditure(psa_income_expenditure, %{field: new_value})
      {:ok, %PsaIncomeExpenditure{}}

      iex> update_psa_income_expenditure(psa_income_expenditure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psa_income_expenditure(%PsaIncomeExpenditure{} = psa_income_expenditure, attrs) do
    psa_income_expenditure
    |> PsaIncomeExpenditure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psa_income_expenditure.

  ## Examples

      iex> delete_psa_income_expenditure(psa_income_expenditure)
      {:ok, %PsaIncomeExpenditure{}}

      iex> delete_psa_income_expenditure(psa_income_expenditure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psa_income_expenditure(%PsaIncomeExpenditure{} = psa_income_expenditure) do
    Repo.delete(psa_income_expenditure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psa_income_expenditure changes.

  ## Examples

      iex> change_psa_income_expenditure(psa_income_expenditure)
      %Ecto.Changeset{data: %PsaIncomeExpenditure{}}

  """
  def change_psa_income_expenditure(%PsaIncomeExpenditure{} = psa_income_expenditure, attrs \\ %{}) do
    PsaIncomeExpenditure.changeset(psa_income_expenditure, attrs)
  end

  alias Beacon.Stats.PsaPriceIndex

  @doc """
  Returns the list of psa_price_indices.

  ## Examples

      iex> list_psa_price_indices()
      [%PsaPriceIndex{}, ...]

  """
  def list_psa_price_indices do
    Repo.all(PsaPriceIndex)
  end

  @doc """
  Gets a single psa_price_index.

  Raises `Ecto.NoResultsError` if the Psa price index does not exist.

  ## Examples

      iex> get_psa_price_index!(123)
      %PsaPriceIndex{}

      iex> get_psa_price_index!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psa_price_index!(id), do: Repo.get!(PsaPriceIndex, id)

  @doc """
  Creates a psa_price_index.

  ## Examples

      iex> create_psa_price_index(%{field: value})
      {:ok, %PsaPriceIndex{}}

      iex> create_psa_price_index(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psa_price_index(attrs) do
    %PsaPriceIndex{}
    |> PsaPriceIndex.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psa_price_index.

  ## Examples

      iex> update_psa_price_index(psa_price_index, %{field: new_value})
      {:ok, %PsaPriceIndex{}}

      iex> update_psa_price_index(psa_price_index, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psa_price_index(%PsaPriceIndex{} = psa_price_index, attrs) do
    psa_price_index
    |> PsaPriceIndex.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psa_price_index.

  ## Examples

      iex> delete_psa_price_index(psa_price_index)
      {:ok, %PsaPriceIndex{}}

      iex> delete_psa_price_index(psa_price_index)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psa_price_index(%PsaPriceIndex{} = psa_price_index) do
    Repo.delete(psa_price_index)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psa_price_index changes.

  ## Examples

      iex> change_psa_price_index(psa_price_index)
      %Ecto.Changeset{data: %PsaPriceIndex{}}

  """
  def change_psa_price_index(%PsaPriceIndex{} = psa_price_index, attrs \\ %{}) do
    PsaPriceIndex.changeset(psa_price_index, attrs)
  end

  alias Beacon.Stats.PsaEconomicPerformance

  @doc """
  Returns the list of psa_economic_performances.

  ## Examples

      iex> list_psa_economic_performances()
      [%PsaEconomicPerformance{}, ...]

  """
  def list_psa_economic_performances do
    Repo.all(PsaEconomicPerformance)
  end

  @doc """
  Gets a single psa_economic_performance.

  Raises `Ecto.NoResultsError` if the Psa economic performance does not exist.

  ## Examples

      iex> get_psa_economic_performance!(123)
      %PsaEconomicPerformance{}

      iex> get_psa_economic_performance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psa_economic_performance!(id), do: Repo.get!(PsaEconomicPerformance, id)

  @doc """
  Creates a psa_economic_performance.

  ## Examples

      iex> create_psa_economic_performance(%{field: value})
      {:ok, %PsaEconomicPerformance{}}

      iex> create_psa_economic_performance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psa_economic_performance(attrs) do
    %PsaEconomicPerformance{}
    |> PsaEconomicPerformance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psa_economic_performance.

  ## Examples

      iex> update_psa_economic_performance(psa_economic_performance, %{field: new_value})
      {:ok, %PsaEconomicPerformance{}}

      iex> update_psa_economic_performance(psa_economic_performance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psa_economic_performance(%PsaEconomicPerformance{} = psa_economic_performance, attrs) do
    psa_economic_performance
    |> PsaEconomicPerformance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psa_economic_performance.

  ## Examples

      iex> delete_psa_economic_performance(psa_economic_performance)
      {:ok, %PsaEconomicPerformance{}}

      iex> delete_psa_economic_performance(psa_economic_performance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psa_economic_performance(%PsaEconomicPerformance{} = psa_economic_performance) do
    Repo.delete(psa_economic_performance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psa_economic_performance changes.

  ## Examples

      iex> change_psa_economic_performance(psa_economic_performance)
      %Ecto.Changeset{data: %PsaEconomicPerformance{}}

  """
  def change_psa_economic_performance(%PsaEconomicPerformance{} = psa_economic_performance, attrs \\ %{}) do
    PsaEconomicPerformance.changeset(psa_economic_performance, attrs)
  end
end
