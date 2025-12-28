defmodule Beacon.Iam do
  @moduledoc """
  The Iam context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Iam.Profile

  @doc """
  Returns the list of profiles.

  ## Examples

      iex> list_profiles()
      [%Profile{}, ...]

  """
  def list_profiles do
    Repo.all(Profile)
  end

  @doc """
  Gets a single profile.

  Raises `Ecto.NoResultsError` if the Profile does not exist.

  ## Examples

      iex> get_profile!(123)
      %Profile{}

      iex> get_profile!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  # @doc """
  # Creates a profile.

  # ## Examples

  #     iex> create_profile(%{field: value})
  #     {:ok, %Profile{}}

  #     iex> create_profile(%{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # """
  # def create_profile(attrs) do
  #   %Profile{}
  #   |> Profile.changeset(attrs)
  #   |> Repo.insert()
  # end

  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  # @doc """
  # Deletes a profile.

  # ## Examples

  #     iex> delete_profile(profile)
  #     {:ok, %Profile{}}

  #     iex> delete_profile(profile)
  #     {:error, %Ecto.Changeset{}}

  # """
  # def delete_profile(%Profile{} = profile) do
  #   Repo.delete(profile)
  # end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile changes.

  ## Examples

      iex> change_profile(profile)
      %Ecto.Changeset{data: %Profile{}}

  """
  def change_profile(%Profile{} = profile, attrs \\ %{}) do
    Profile.changeset(profile, attrs)
  end

  alias Beacon.Iam.ProfileSetting

  @doc """
  Returns the list of profile_settings.

  ## Examples

      iex> list_profile_settings()
      [%ProfileSetting{}, ...]

  """
  def list_profile_settings do
    Repo.all(ProfileSetting)
  end

  @doc """
  Gets a single profile_setting.

  Raises `Ecto.NoResultsError` if the Profile setting does not exist.

  ## Examples

      iex> get_profile_setting!(123)
      %ProfileSetting{}

      iex> get_profile_setting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile_setting!(id), do: Repo.get!(ProfileSetting, id)

  @doc """
  Creates a profile_setting.

  ## Examples

      iex> create_profile_setting(%{field: value})
      {:ok, %ProfileSetting{}}

      iex> create_profile_setting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profile_setting(attrs) do
    %ProfileSetting{}
    |> ProfileSetting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profile_setting.

  ## Examples

      iex> update_profile_setting(profile_setting, %{field: new_value})
      {:ok, %ProfileSetting{}}

      iex> update_profile_setting(profile_setting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile_setting(%ProfileSetting{} = profile_setting, attrs) do
    profile_setting
    |> ProfileSetting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profile_setting.

  ## Examples

      iex> delete_profile_setting(profile_setting)
      {:ok, %ProfileSetting{}}

      iex> delete_profile_setting(profile_setting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profile_setting(%ProfileSetting{} = profile_setting) do
    Repo.delete(profile_setting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile_setting changes.

  ## Examples

      iex> change_profile_setting(profile_setting)
      %Ecto.Changeset{data: %ProfileSetting{}}

  """
  def change_profile_setting(%ProfileSetting{} = profile_setting, attrs \\ %{}) do
    ProfileSetting.changeset(profile_setting, attrs)
  end

  alias Beacon.Iam.ApiKey

  @doc """
  Returns the list of api_keys.

  ## Examples

      iex> list_api_keys()
      [%ApiKey{}, ...]

  """
  def list_api_keys do
    Repo.all(ApiKey)
  end

  @doc """
  Gets a single api_key.

  Raises `Ecto.NoResultsError` if the Api key does not exist.

  ## Examples

      iex> get_api_key!(123)
      %ApiKey{}

      iex> get_api_key!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_key!(id), do: Repo.get!(ApiKey, id)

  @doc """
  Creates a api_key.

  ## Examples

      iex> create_api_key(%{field: value})
      {:ok, %ApiKey{}}

      iex> create_api_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_key(attrs) do
    %ApiKey{}
    |> ApiKey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_key.

  ## Examples

      iex> update_api_key(api_key, %{field: new_value})
      {:ok, %ApiKey{}}

      iex> update_api_key(api_key, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_key(%ApiKey{} = api_key, attrs) do
    api_key
    |> ApiKey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a api_key.

  ## Examples

      iex> delete_api_key(api_key)
      {:ok, %ApiKey{}}

      iex> delete_api_key(api_key)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_key(%ApiKey{} = api_key) do
    Repo.delete(api_key)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_key changes.

  ## Examples

      iex> change_api_key(api_key)
      %Ecto.Changeset{data: %ApiKey{}}

  """
  def change_api_key(%ApiKey{} = api_key, attrs \\ %{}) do
    ApiKey.changeset(api_key, attrs)
  end
end
