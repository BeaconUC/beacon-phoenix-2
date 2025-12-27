defmodule Beacon.Ops do
  @moduledoc """
  The Ops context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Ops.Outage

  @doc """
  Returns the list of outages.

  ## Examples

      iex> list_outages()
      [%Outage{}, ...]

  """
  def list_outages do
    Repo.all(Outage)
  end

  @doc """
  Gets a single outage.

  Raises `Ecto.NoResultsError` if the Outage does not exist.

  ## Examples

      iex> get_outage!(123)
      %Outage{}

      iex> get_outage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_outage!(id), do: Repo.get!(Outage, id)

  @doc """
  Creates a outage.

  ## Examples

      iex> create_outage(%{field: value})
      {:ok, %Outage{}}

      iex> create_outage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outage(%Profile{} = profile, attrs) do
    %Outage{}
    |> Outage.create_changeset(attrs)
    |> Ecto.Changeset.put_change(:created_by_id, profile.id)
    |> Ecto.Changeset.put_change(:updated_by_id, profile.id)
    |> Repo.insert()
  end

  @doc """
  Updates a outage.

  ## Examples

      iex> update_outage(outage, %{field: new_value})
      {:ok, %Outage{}}

      iex> update_outage(outage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outage(%Profile{} = actor, %Outage{} = outage, attrs) do
    outage
    |> Outage.update_changeset(attrs)
    |> Ecto.Changeset.put_change(:updated_by_id, actor.id)
    |> Repo.update()
  end

  @doc """
  Deletes a outage.

  ## Examples

      iex> delete_outage(outage)
      {:ok, %Outage{}}

      iex> delete_outage(outage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outage(%Outage{} = outage) do
    Repo.delete(outage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outage changes.

  ## Examples

      iex> change_outage(outage)
      %Ecto.Changeset{data: %Outage{}}

  """
  def change_outage(%Outage{} = outage, attrs \\ %{}) do
    Outage.update_changeset(outage, attrs)
  end
end
