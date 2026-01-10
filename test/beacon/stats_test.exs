defmodule Beacon.StatsTest do
  use Beacon.DataCase

  alias Beacon.Stats

  describe "weather_observations" do
    alias Beacon.Stats.WeatherObservation

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_weather_observations/0 returns all weather_observations" do
      weather_observation = weather_observation_fixture()
      assert Stats.list_weather_observations() == [weather_observation]
    end

    test "get_weather_observation!/1 returns the weather_observation with given id" do
      weather_observation = weather_observation_fixture()
      assert Stats.get_weather_observation!(weather_observation.id) == weather_observation
    end

    test "create_weather_observation/1 with valid data creates a weather_observation" do
      valid_attrs = %{}

      assert {:ok, %WeatherObservation{} = weather_observation} =
               Stats.create_weather_observation(valid_attrs)
    end

    test "create_weather_observation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_weather_observation(@invalid_attrs)
    end

    test "update_weather_observation/2 with valid data updates the weather_observation" do
      weather_observation = weather_observation_fixture()
      update_attrs = %{}

      assert {:ok, %WeatherObservation{} = weather_observation} =
               Stats.update_weather_observation(weather_observation, update_attrs)
    end

    test "update_weather_observation/2 with invalid data returns error changeset" do
      weather_observation = weather_observation_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_weather_observation(weather_observation, @invalid_attrs)

      assert weather_observation == Stats.get_weather_observation!(weather_observation.id)
    end

    test "delete_weather_observation/1 deletes the weather_observation" do
      weather_observation = weather_observation_fixture()
      assert {:ok, %WeatherObservation{}} = Stats.delete_weather_observation(weather_observation)

      assert_raise Ecto.NoResultsError, fn ->
        Stats.get_weather_observation!(weather_observation.id)
      end
    end

    test "change_weather_observation/1 returns a weather_observation changeset" do
      weather_observation = weather_observation_fixture()
      assert %Ecto.Changeset{} = Stats.change_weather_observation(weather_observation)
    end
  end

  describe "psa_population_stats" do
    alias Beacon.Stats.PsaPopulationStat

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_psa_population_stats/0 returns all psa_population_stats" do
      psa_population_stat = psa_population_stat_fixture()
      assert Stats.list_psa_population_stats() == [psa_population_stat]
    end

    test "get_psa_population_stat!/1 returns the psa_population_stat with given id" do
      psa_population_stat = psa_population_stat_fixture()
      assert Stats.get_psa_population_stat!(psa_population_stat.id) == psa_population_stat
    end

    test "create_psa_population_stat/1 with valid data creates a psa_population_stat" do
      valid_attrs = %{}

      assert {:ok, %PsaPopulationStat{} = psa_population_stat} =
               Stats.create_psa_population_stat(valid_attrs)
    end

    test "create_psa_population_stat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_psa_population_stat(@invalid_attrs)
    end

    test "update_psa_population_stat/2 with valid data updates the psa_population_stat" do
      psa_population_stat = psa_population_stat_fixture()
      update_attrs = %{}

      assert {:ok, %PsaPopulationStat{} = psa_population_stat} =
               Stats.update_psa_population_stat(psa_population_stat, update_attrs)
    end

    test "update_psa_population_stat/2 with invalid data returns error changeset" do
      psa_population_stat = psa_population_stat_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_psa_population_stat(psa_population_stat, @invalid_attrs)

      assert psa_population_stat == Stats.get_psa_population_stat!(psa_population_stat.id)
    end

    test "delete_psa_population_stat/1 deletes the psa_population_stat" do
      psa_population_stat = psa_population_stat_fixture()
      assert {:ok, %PsaPopulationStat{}} = Stats.delete_psa_population_stat(psa_population_stat)

      assert_raise Ecto.NoResultsError, fn ->
        Stats.get_psa_population_stat!(psa_population_stat.id)
      end
    end

    test "change_psa_population_stat/1 returns a psa_population_stat changeset" do
      psa_population_stat = psa_population_stat_fixture()
      assert %Ecto.Changeset{} = Stats.change_psa_population_stat(psa_population_stat)
    end
  end

  describe "psa_poverty_stats" do
    alias Beacon.Stats.PsaPovertyStat

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_psa_poverty_stats/0 returns all psa_poverty_stats" do
      psa_poverty_stat = psa_poverty_stat_fixture()
      assert Stats.list_psa_poverty_stats() == [psa_poverty_stat]
    end

    test "get_psa_poverty_stat!/1 returns the psa_poverty_stat with given id" do
      psa_poverty_stat = psa_poverty_stat_fixture()
      assert Stats.get_psa_poverty_stat!(psa_poverty_stat.id) == psa_poverty_stat
    end

    test "create_psa_poverty_stat/1 with valid data creates a psa_poverty_stat" do
      valid_attrs = %{}

      assert {:ok, %PsaPovertyStat{} = psa_poverty_stat} =
               Stats.create_psa_poverty_stat(valid_attrs)
    end

    test "create_psa_poverty_stat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_psa_poverty_stat(@invalid_attrs)
    end

    test "update_psa_poverty_stat/2 with valid data updates the psa_poverty_stat" do
      psa_poverty_stat = psa_poverty_stat_fixture()
      update_attrs = %{}

      assert {:ok, %PsaPovertyStat{} = psa_poverty_stat} =
               Stats.update_psa_poverty_stat(psa_poverty_stat, update_attrs)
    end

    test "update_psa_poverty_stat/2 with invalid data returns error changeset" do
      psa_poverty_stat = psa_poverty_stat_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_psa_poverty_stat(psa_poverty_stat, @invalid_attrs)

      assert psa_poverty_stat == Stats.get_psa_poverty_stat!(psa_poverty_stat.id)
    end

    test "delete_psa_poverty_stat/1 deletes the psa_poverty_stat" do
      psa_poverty_stat = psa_poverty_stat_fixture()
      assert {:ok, %PsaPovertyStat{}} = Stats.delete_psa_poverty_stat(psa_poverty_stat)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_psa_poverty_stat!(psa_poverty_stat.id) end
    end

    test "change_psa_poverty_stat/1 returns a psa_poverty_stat changeset" do
      psa_poverty_stat = psa_poverty_stat_fixture()
      assert %Ecto.Changeset{} = Stats.change_psa_poverty_stat(psa_poverty_stat)
    end
  end

  describe "psa_income_expenditures" do
    alias Beacon.Stats.PsaIncomeExpenditure

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_psa_income_expenditures/0 returns all psa_income_expenditures" do
      psa_income_expenditure = psa_income_expenditure_fixture()
      assert Stats.list_psa_income_expenditures() == [psa_income_expenditure]
    end

    test "get_psa_income_expenditure!/1 returns the psa_income_expenditure with given id" do
      psa_income_expenditure = psa_income_expenditure_fixture()

      assert Stats.get_psa_income_expenditure!(psa_income_expenditure.id) ==
               psa_income_expenditure
    end

    test "create_psa_income_expenditure/1 with valid data creates a psa_income_expenditure" do
      valid_attrs = %{}

      assert {:ok, %PsaIncomeExpenditure{} = psa_income_expenditure} =
               Stats.create_psa_income_expenditure(valid_attrs)
    end

    test "create_psa_income_expenditure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_psa_income_expenditure(@invalid_attrs)
    end

    test "update_psa_income_expenditure/2 with valid data updates the psa_income_expenditure" do
      psa_income_expenditure = psa_income_expenditure_fixture()
      update_attrs = %{}

      assert {:ok, %PsaIncomeExpenditure{} = psa_income_expenditure} =
               Stats.update_psa_income_expenditure(psa_income_expenditure, update_attrs)
    end

    test "update_psa_income_expenditure/2 with invalid data returns error changeset" do
      psa_income_expenditure = psa_income_expenditure_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_psa_income_expenditure(psa_income_expenditure, @invalid_attrs)

      assert psa_income_expenditure ==
               Stats.get_psa_income_expenditure!(psa_income_expenditure.id)
    end

    test "delete_psa_income_expenditure/1 deletes the psa_income_expenditure" do
      psa_income_expenditure = psa_income_expenditure_fixture()

      assert {:ok, %PsaIncomeExpenditure{}} =
               Stats.delete_psa_income_expenditure(psa_income_expenditure)

      assert_raise Ecto.NoResultsError, fn ->
        Stats.get_psa_income_expenditure!(psa_income_expenditure.id)
      end
    end

    test "change_psa_income_expenditure/1 returns a psa_income_expenditure changeset" do
      psa_income_expenditure = psa_income_expenditure_fixture()
      assert %Ecto.Changeset{} = Stats.change_psa_income_expenditure(psa_income_expenditure)
    end
  end

  describe "psa_price_indices" do
    alias Beacon.Stats.PsaPriceIndex

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_psa_price_indices/0 returns all psa_price_indices" do
      psa_price_index = psa_price_index_fixture()
      assert Stats.list_psa_price_indices() == [psa_price_index]
    end

    test "get_psa_price_index!/1 returns the psa_price_index with given id" do
      psa_price_index = psa_price_index_fixture()
      assert Stats.get_psa_price_index!(psa_price_index.id) == psa_price_index
    end

    test "create_psa_price_index/1 with valid data creates a psa_price_index" do
      valid_attrs = %{}

      assert {:ok, %PsaPriceIndex{} = psa_price_index} = Stats.create_psa_price_index(valid_attrs)
    end

    test "create_psa_price_index/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_psa_price_index(@invalid_attrs)
    end

    test "update_psa_price_index/2 with valid data updates the psa_price_index" do
      psa_price_index = psa_price_index_fixture()
      update_attrs = %{}

      assert {:ok, %PsaPriceIndex{} = psa_price_index} =
               Stats.update_psa_price_index(psa_price_index, update_attrs)
    end

    test "update_psa_price_index/2 with invalid data returns error changeset" do
      psa_price_index = psa_price_index_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_psa_price_index(psa_price_index, @invalid_attrs)

      assert psa_price_index == Stats.get_psa_price_index!(psa_price_index.id)
    end

    test "delete_psa_price_index/1 deletes the psa_price_index" do
      psa_price_index = psa_price_index_fixture()
      assert {:ok, %PsaPriceIndex{}} = Stats.delete_psa_price_index(psa_price_index)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_psa_price_index!(psa_price_index.id) end
    end

    test "change_psa_price_index/1 returns a psa_price_index changeset" do
      psa_price_index = psa_price_index_fixture()
      assert %Ecto.Changeset{} = Stats.change_psa_price_index(psa_price_index)
    end
  end

  describe "psa_economic_performances" do
    alias Beacon.Stats.PsaEconomicPerformance

    import Beacon.StatsFixtures

    @invalid_attrs %{}

    test "list_psa_economic_performances/0 returns all psa_economic_performances" do
      psa_economic_performance = psa_economic_performance_fixture()
      assert Stats.list_psa_economic_performances() == [psa_economic_performance]
    end

    test "get_psa_economic_performance!/1 returns the psa_economic_performance with given id" do
      psa_economic_performance = psa_economic_performance_fixture()

      assert Stats.get_psa_economic_performance!(psa_economic_performance.id) ==
               psa_economic_performance
    end

    test "create_psa_economic_performance/1 with valid data creates a psa_economic_performance" do
      valid_attrs = %{}

      assert {:ok, %PsaEconomicPerformance{} = psa_economic_performance} =
               Stats.create_psa_economic_performance(valid_attrs)
    end

    test "create_psa_economic_performance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_psa_economic_performance(@invalid_attrs)
    end

    test "update_psa_economic_performance/2 with valid data updates the psa_economic_performance" do
      psa_economic_performance = psa_economic_performance_fixture()
      update_attrs = %{}

      assert {:ok, %PsaEconomicPerformance{} = psa_economic_performance} =
               Stats.update_psa_economic_performance(psa_economic_performance, update_attrs)
    end

    test "update_psa_economic_performance/2 with invalid data returns error changeset" do
      psa_economic_performance = psa_economic_performance_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Stats.update_psa_economic_performance(psa_economic_performance, @invalid_attrs)

      assert psa_economic_performance ==
               Stats.get_psa_economic_performance!(psa_economic_performance.id)
    end

    test "delete_psa_economic_performance/1 deletes the psa_economic_performance" do
      psa_economic_performance = psa_economic_performance_fixture()

      assert {:ok, %PsaEconomicPerformance{}} =
               Stats.delete_psa_economic_performance(psa_economic_performance)

      assert_raise Ecto.NoResultsError, fn ->
        Stats.get_psa_economic_performance!(psa_economic_performance.id)
      end
    end

    test "change_psa_economic_performance/1 returns a psa_economic_performance changeset" do
      psa_economic_performance = psa_economic_performance_fixture()
      assert %Ecto.Changeset{} = Stats.change_psa_economic_performance(psa_economic_performance)
    end
  end
end
