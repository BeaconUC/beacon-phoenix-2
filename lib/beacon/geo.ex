defmodule Beacon.Geo do
  @moduledoc """
  The Geo context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Geo.Region
  alias Beacon.Geo.Province
  alias Beacon.Geo.City
  alias Beacon.Geo.Barangay
  alias Beacon.Geo.Provider
  alias Beacon.Geo.Feeder

  @doc """
  Returns the list of regions.

  ## Examples

      iex> list_regions()
      [%Region{}, ...]

  """
  def list_regions do
    Repo.all(Region)
  end

  @doc """
  Gets a single region.

  Raises `Ecto.NoResultsError` if the Region does not exist.

  ## Examples

      iex> get_region!(123)
      %Region{}

      iex> get_region!(456)
      ** (Ecto.NoResultsError)

  """
  def get_region!(id), do: Repo.get!(Region, id)

  @doc """
  Creates a region.

  ## Examples

      iex> create_region(%{field: value})
      {:ok, %Region{}}

      iex> create_region(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_region(attrs) do
    %Region{}
    |> Region.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a region.

  ## Examples

      iex> update_region(region, %{field: new_value})
      {:ok, %Region{}}

      iex> update_region(region, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_region(%Region{} = region, attrs) do
    region
    |> Region.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a region.

  ## Examples

      iex> delete_region(region)
      {:ok, %Region{}}

      iex> delete_region(region)
      {:error, %Ecto.Changeset{}}

  """
  def delete_region(%Region{} = region) do
    Repo.delete(region)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking region changes.

  ## Examples

      iex> change_region(region)
      %Ecto.Changeset{data: %Region{}}

  """
  def change_region(%Region{} = region, attrs \\ %{}) do
    Region.changeset(region, attrs)
  end



  @doc """
  Returns the list of provinces.

  ## Examples

      iex> list_provinces()
      [%Province{}, ...]

  """
  def list_provinces do
    Repo.all(Province)
  end

  @doc """
  Gets a single province.

  Raises `Ecto.NoResultsError` if the Province does not exist.

  ## Examples

      iex> get_province!(123)
      %Province{}

      iex> get_province!(456)
      ** (Ecto.NoResultsError)

  """
  def get_province!(id), do: Repo.get!(Province, id)

  @doc """
  Creates a province.

  ## Examples

      iex> create_province(%{field: value})
      {:ok, %Province{}}

      iex> create_province(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_province(attrs) do
    %Province{}
    |> Province.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a province.

  ## Examples

      iex> update_province(province, %{field: new_value})
      {:ok, %Province{}}

      iex> update_province(province, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_province(%Province{} = province, attrs) do
    province
    |> Province.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a province.

  ## Examples

      iex> delete_province(province)
      {:ok, %Province{}}

      iex> delete_province(province)
      {:error, %Ecto.Changeset{}}

  """
  def delete_province(%Province{} = province) do
    Repo.delete(province)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking province changes.

  ## Examples

      iex> change_province(province)
      %Ecto.Changeset{data: %Province{}}

  """
  def change_province(%Province{} = province, attrs \\ %{}) do
    Province.changeset(province, attrs)
  end



  @doc """
  Returns the list of cities.

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  def list_cities do
    Repo.all(City)
  end

  @doc """
  Gets a single city.

  Raises `Ecto.NoResultsError` if the City does not exist.

  ## Examples

      iex> get_city!(123)
      %City{}

      iex> get_city!(456)
      ** (Ecto.NoResultsError)

  """
  def get_city!(id), do: Repo.get!(City, id)

  @doc """
  Creates a city.

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_city(attrs) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a city.

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_city(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a city.

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  def delete_city(%City{} = city) do
    Repo.delete(city)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking city changes.

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{data: %City{}}

  """
  def change_city(%City{} = city, attrs \\ %{}) do
    City.changeset(city, attrs)
  end



  @doc """
  Returns the list of barangays.

  ## Examples

      iex> list_barangays()
      [%Barangay{}, ...]

  """
  def list_barangays do
    Repo.all(Barangay)
  end

  @doc """
  Gets a single barangay.

  Raises `Ecto.NoResultsError` if the Barangay does not exist.

  ## Examples

      iex> get_barangay!(123)
      %Barangay{}

      iex> get_barangay!(456)
      ** (Ecto.NoResultsError)

  """
  def get_barangay!(id), do: Repo.get!(Barangay, id)

  @doc """
  Creates a barangay.

  ## Examples

      iex> create_barangay(%{field: value})
      {:ok, %Barangay{}}

      iex> create_barangay(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_barangay(attrs) do
    %Barangay{}
    |> Barangay.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a barangay.

  ## Examples

      iex> update_barangay(barangay, %{field: new_value})
      {:ok, %Barangay{}}

      iex> update_barangay(barangay, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_barangay(%Barangay{} = barangay, attrs) do
    barangay
    |> Barangay.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a barangay.

  ## Examples

      iex> delete_barangay(barangay)
      {:ok, %Barangay{}}

      iex> delete_barangay(barangay)
      {:error, %Ecto.Changeset{}}

  """
  def delete_barangay(%Barangay{} = barangay) do
    Repo.delete(barangay)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking barangay changes.

  ## Examples

      iex> change_barangay(barangay)
      %Ecto.Changeset{data: %Barangay{}}

  """
  def change_barangay(%Barangay{} = barangay, attrs \\ %{}) do
    Barangay.changeset(barangay, attrs)
  end



  @doc """
  Returns the list of providers.

  ## Examples

      iex> list_providers()
      [%Provider{}, ...]

  """
  def list_providers do
    Repo.all(Provider)
  end

  @doc """
  Gets a single provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

  ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider!(id), do: Repo.get!(Provider, id)

  @doc """
  Creates a provider.

  ## Examples

      iex> create_provider(%{field: value})
      {:ok, %Provider{}}

      iex> create_provider(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_provider(attrs) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a provider.

  ## Examples

      iex> update_provider(provider, %{field: new_value})
      {:ok, %Provider{}}

      iex> update_provider(provider, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_provider(%Provider{} = provider, attrs) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a provider.

  ## Examples

      iex> delete_provider(provider)
      {:ok, %Provider{}}

      iex> delete_provider(provider)
      {:error, %Ecto.Changeset{}}

  """
  def delete_provider(%Provider{} = provider) do
    Repo.delete(provider)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking provider changes.

  ## Examples

      iex> change_provider(provider)
      %Ecto.Changeset{data: %Provider{}}

  """
  def change_provider(%Provider{} = provider, attrs \\ %{}) do
    Provider.changeset(provider, attrs)
  end

  @doc """
  Returns the list of feeders.

  ## Examples

      iex> list_feeders()
      [%Feeder{}, ...]

  """
  def list_feeders do
    Repo.all(Feeder)
  end

  @doc """
  Gets a single feeder.

  Raises `Ecto.NoResultsError` if the Feeder does not exist.

  ## Examples

      iex> get_feeder!(123)
      %Feeder{}

      iex> get_feeder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feeder!(id), do: Repo.get!(Feeder, id)

  @doc """
  Creates a feeder.

  ## Examples

      iex> create_feeder(%{field: value})
      {:ok, %Feeder{}}

      iex> create_feeder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feeder(attrs) do
    %Feeder{}
    |> Feeder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feeder.

  ## Examples

      iex> update_feeder(feeder, %{field: new_value})
      {:ok, %Feeder{}}

      iex> update_feeder(feeder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feeder(%Feeder{} = feeder, attrs) do
    feeder
    |> Feeder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feeder.

  ## Examples

      iex> delete_feeder(feeder)
      {:ok, %Feeder{}}

      iex> delete_feeder(feeder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feeder(%Feeder{} = feeder) do
    Repo.delete(feeder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feeder changes.

  ## Examples

      iex> change_feeder(feeder)
      %Ecto.Changeset{data: %Feeder{}}

  """
  def change_feeder(%Feeder{} = feeder, attrs \\ %{}) do
    Feeder.changeset(feeder, attrs)
  end

  alias Beacon.Geo.BarangayFeeder

  @doc """
  Returns the list of barangay_feeders.

  ## Examples

      iex> list_barangay_feeders()
      [%BarangayFeeder{}, ...]

  """
  def list_barangay_feeders do
    Repo.all(BarangayFeeder)
  end

  @doc """
  Gets a single barangay_feeder.

  Raises `Ecto.NoResultsError` if the Barangay feeder does not exist.

  ## Examples

      iex> get_barangay_feeder!(123)
      %BarangayFeeder{}

      iex> get_barangay_feeder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_barangay_feeder!(id), do: Repo.get!(BarangayFeeder, id)

  @doc """
  Creates a barangay_feeder.

  ## Examples

      iex> create_barangay_feeder(%{field: value})
      {:ok, %BarangayFeeder{}}

      iex> create_barangay_feeder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_barangay_feeder(attrs) do
    %BarangayFeeder{}
    |> BarangayFeeder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a barangay_feeder.

  ## Examples

      iex> update_barangay_feeder(barangay_feeder, %{field: new_value})
      {:ok, %BarangayFeeder{}}

      iex> update_barangay_feeder(barangay_feeder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_barangay_feeder(%BarangayFeeder{} = barangay_feeder, attrs) do
    barangay_feeder
    |> BarangayFeeder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a barangay_feeder.

  ## Examples

      iex> delete_barangay_feeder(barangay_feeder)
      {:ok, %BarangayFeeder{}}

      iex> delete_barangay_feeder(barangay_feeder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_barangay_feeder(%BarangayFeeder{} = barangay_feeder) do
    Repo.delete(barangay_feeder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking barangay_feeder changes.

  ## Examples

      iex> change_barangay_feeder(barangay_feeder)
      %Ecto.Changeset{data: %BarangayFeeder{}}

  """
  def change_barangay_feeder(%BarangayFeeder{} = barangay_feeder, attrs \\ %{}) do
    BarangayFeeder.changeset(barangay_feeder, attrs)
  end
end
