defmodule Beacon.Iam do
  @moduledoc """
  The Iam context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Iam.Profile
  alias Beacon.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any profile changes.
  """
  def subscribe_profile(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Returns the list of profiles--no-migration.

  ## Examples

      iex> list_profiles--no-migration(scope)
      [%Profile{}, ...]

  """
  def list_profiles(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Gets a single profile.

  Raises if the Profile does not exist.

  ## Examples

      iex> get_profile!(scope, 123)
      %Profile{}

  """
  def get_profile!(%Scope{} = _scope, id), do: raise "TODO"

  @doc """
  Creates a profile.

  ## Examples

      iex> create_profile(scope, %{field: value})
      {:ok, %Profile{}}

      iex> create_profile(scope, %{field: bad_value})
      {:error, ...}

  """
  def create_profile(%Scope{} = _scope, attrs) do
    raise "TODO"
  end

  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(scope, profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(scope, profile, %{field: bad_value})
      {:error, ...}

  """
  def update_profile(%Scope{} = _scope, %Profile{} = profile, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Profile.

  ## Examples

      iex> delete_profile(scope, profile)
      {:ok, %Profile{}}

      iex> delete_profile(scope, profile)
      {:error, ...}

  """
  def delete_profile(%Scope{} = _scope, %Profile{} = profile) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking profile changes.

  ## Examples

      iex> change_profile(scope, profile)
      %Todo{...}

  """
  def change_profile(%Scope{} = _scope, %Profile{} = profile, _attrs \\ %{}) do
    raise "TODO"
  end
end
