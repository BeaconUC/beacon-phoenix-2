defmodule Beacon.Sys do
  @moduledoc """
  The Sys context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Sys.SystemConfig

  @doc """
  Returns the list of system_configs.

  ## Examples

      iex> list_system_configs()
      [%SystemConfig{}, ...]

  """
  def list_system_configs do
    Repo.all(SystemConfig)
  end

  @doc """
  Gets a single system_config.

  Raises `Ecto.NoResultsError` if the System config does not exist.

  ## Examples

      iex> get_system_config!(123)
      %SystemConfig{}

      iex> get_system_config!(456)
      ** (Ecto.NoResultsError)

  """
  def get_system_config!(id), do: Repo.get!(SystemConfig, id)

  @doc """
  Creates a system_config.

  ## Examples

      iex> create_system_config(%{field: value})
      {:ok, %SystemConfig{}}

      iex> create_system_config(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_system_config(attrs) do
    %SystemConfig{}
    |> SystemConfig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a system_config.

  ## Examples

      iex> update_system_config(system_config, %{field: new_value})
      {:ok, %SystemConfig{}}

      iex> update_system_config(system_config, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_system_config(%SystemConfig{} = system_config, attrs) do
    system_config
    |> SystemConfig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a system_config.

  ## Examples

      iex> delete_system_config(system_config)
      {:ok, %SystemConfig{}}

      iex> delete_system_config(system_config)
      {:error, %Ecto.Changeset{}}

  """
  def delete_system_config(%SystemConfig{} = system_config) do
    Repo.delete(system_config)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking system_config changes.

  ## Examples

      iex> change_system_config(system_config)
      %Ecto.Changeset{data: %SystemConfig{}}

  """
  def change_system_config(%SystemConfig{} = system_config, attrs \\ %{}) do
    SystemConfig.changeset(system_config, attrs)
  end
end
