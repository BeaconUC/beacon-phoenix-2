defmodule Beacon.GeoTest do
  use Beacon.DataCase

  alias Beacon.Geo

  describe "regions" do
    alias Beacon.Geo.Region

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Geo.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Geo.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      valid_attrs = %{}

      assert {:ok, %Region{} = region} = Geo.create_region(valid_attrs)
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      update_attrs = %{}

      assert {:ok, %Region{} = region} = Geo.update_region(region, update_attrs)
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_region(region, @invalid_attrs)
      assert region == Geo.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Geo.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Geo.change_region(region)
    end
  end

  describe "provinces" do
    alias Beacon.Geo.Province

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_provinces/0 returns all provinces" do
      province = province_fixture()
      assert Geo.list_provinces() == [province]
    end

    test "get_province!/1 returns the province with given id" do
      province = province_fixture()
      assert Geo.get_province!(province.id) == province
    end

    test "create_province/1 with valid data creates a province" do
      valid_attrs = %{}

      assert {:ok, %Province{} = province} = Geo.create_province(valid_attrs)
    end

    test "create_province/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_province(@invalid_attrs)
    end

    test "update_province/2 with valid data updates the province" do
      province = province_fixture()
      update_attrs = %{}

      assert {:ok, %Province{} = province} = Geo.update_province(province, update_attrs)
    end

    test "update_province/2 with invalid data returns error changeset" do
      province = province_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_province(province, @invalid_attrs)
      assert province == Geo.get_province!(province.id)
    end

    test "delete_province/1 deletes the province" do
      province = province_fixture()
      assert {:ok, %Province{}} = Geo.delete_province(province)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_province!(province.id) end
    end

    test "change_province/1 returns a province changeset" do
      province = province_fixture()
      assert %Ecto.Changeset{} = Geo.change_province(province)
    end
  end

  describe "cities" do
    alias Beacon.Geo.City

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Geo.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Geo.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{}

      assert {:ok, %City{} = city} = Geo.create_city(valid_attrs)
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{}

      assert {:ok, %City{} = city} = Geo.update_city(city, update_attrs)
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_city(city, @invalid_attrs)
      assert city == Geo.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Geo.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Geo.change_city(city)
    end
  end

  describe "barangays" do
    alias Beacon.Geo.Barangay

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_barangays/0 returns all barangays" do
      barangay = barangay_fixture()
      assert Geo.list_barangays() == [barangay]
    end

    test "get_barangay!/1 returns the barangay with given id" do
      barangay = barangay_fixture()
      assert Geo.get_barangay!(barangay.id) == barangay
    end

    test "create_barangay/1 with valid data creates a barangay" do
      valid_attrs = %{}

      assert {:ok, %Barangay{} = barangay} = Geo.create_barangay(valid_attrs)
    end

    test "create_barangay/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_barangay(@invalid_attrs)
    end

    test "update_barangay/2 with valid data updates the barangay" do
      barangay = barangay_fixture()
      update_attrs = %{}

      assert {:ok, %Barangay{} = barangay} = Geo.update_barangay(barangay, update_attrs)
    end

    test "update_barangay/2 with invalid data returns error changeset" do
      barangay = barangay_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_barangay(barangay, @invalid_attrs)
      assert barangay == Geo.get_barangay!(barangay.id)
    end

    test "delete_barangay/1 deletes the barangay" do
      barangay = barangay_fixture()
      assert {:ok, %Barangay{}} = Geo.delete_barangay(barangay)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_barangay!(barangay.id) end
    end

    test "change_barangay/1 returns a barangay changeset" do
      barangay = barangay_fixture()
      assert %Ecto.Changeset{} = Geo.change_barangay(barangay)
    end
  end

  describe "providers" do
    alias Beacon.Geo.Provider

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert Geo.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert Geo.get_provider!(provider.id) == provider
    end

    test "create_provider/1 with valid data creates a provider" do
      valid_attrs = %{}

      assert {:ok, %Provider{} = provider} = Geo.create_provider(valid_attrs)
    end

    test "create_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_provider(@invalid_attrs)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      update_attrs = %{}

      assert {:ok, %Provider{} = provider} = Geo.update_provider(provider, update_attrs)
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_provider(provider, @invalid_attrs)
      assert provider == Geo.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{}} = Geo.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = Geo.change_provider(provider)
    end
  end

  describe "feeders" do
    alias Beacon.Geo.Feeder

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_feeders/0 returns all feeders" do
      feeder = feeder_fixture()
      assert Geo.list_feeders() == [feeder]
    end

    test "get_feeder!/1 returns the feeder with given id" do
      feeder = feeder_fixture()
      assert Geo.get_feeder!(feeder.id) == feeder
    end

    test "create_feeder/1 with valid data creates a feeder" do
      valid_attrs = %{}

      assert {:ok, %Feeder{} = feeder} = Geo.create_feeder(valid_attrs)
    end

    test "create_feeder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_feeder(@invalid_attrs)
    end

    test "update_feeder/2 with valid data updates the feeder" do
      feeder = feeder_fixture()
      update_attrs = %{}

      assert {:ok, %Feeder{} = feeder} = Geo.update_feeder(feeder, update_attrs)
    end

    test "update_feeder/2 with invalid data returns error changeset" do
      feeder = feeder_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_feeder(feeder, @invalid_attrs)
      assert feeder == Geo.get_feeder!(feeder.id)
    end

    test "delete_feeder/1 deletes the feeder" do
      feeder = feeder_fixture()
      assert {:ok, %Feeder{}} = Geo.delete_feeder(feeder)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_feeder!(feeder.id) end
    end

    test "change_feeder/1 returns a feeder changeset" do
      feeder = feeder_fixture()
      assert %Ecto.Changeset{} = Geo.change_feeder(feeder)
    end
  end

  describe "barangay_feeders" do
    alias Beacon.Geo.BarangayFeeder

    import Beacon.GeoFixtures

    @invalid_attrs %{}

    test "list_barangay_feeders/0 returns all barangay_feeders" do
      barangay_feeder = barangay_feeder_fixture()
      assert Geo.list_barangay_feeders() == [barangay_feeder]
    end

    test "get_barangay_feeder!/1 returns the barangay_feeder with given id" do
      barangay_feeder = barangay_feeder_fixture()
      assert Geo.get_barangay_feeder!(barangay_feeder.id) == barangay_feeder
    end

    test "create_barangay_feeder/1 with valid data creates a barangay_feeder" do
      valid_attrs = %{}

      assert {:ok, %BarangayFeeder{} = barangay_feeder} = Geo.create_barangay_feeder(valid_attrs)
    end

    test "create_barangay_feeder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_barangay_feeder(@invalid_attrs)
    end

    test "update_barangay_feeder/2 with valid data updates the barangay_feeder" do
      barangay_feeder = barangay_feeder_fixture()
      update_attrs = %{}

      assert {:ok, %BarangayFeeder{} = barangay_feeder} = Geo.update_barangay_feeder(barangay_feeder, update_attrs)
    end

    test "update_barangay_feeder/2 with invalid data returns error changeset" do
      barangay_feeder = barangay_feeder_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_barangay_feeder(barangay_feeder, @invalid_attrs)
      assert barangay_feeder == Geo.get_barangay_feeder!(barangay_feeder.id)
    end

    test "delete_barangay_feeder/1 deletes the barangay_feeder" do
      barangay_feeder = barangay_feeder_fixture()
      assert {:ok, %BarangayFeeder{}} = Geo.delete_barangay_feeder(barangay_feeder)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_barangay_feeder!(barangay_feeder.id) end
    end

    test "change_barangay_feeder/1 returns a barangay_feeder changeset" do
      barangay_feeder = barangay_feeder_fixture()
      assert %Ecto.Changeset{} = Geo.change_barangay_feeder(barangay_feeder)
    end
  end
end
