defmodule Beacon.Ops do
  @moduledoc """
  The Ops context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Ops.Outage
  alias Beacon.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any outage changes.

  The broadcasted messages match the pattern:

    * {:created, %Outage{}}
    * {:updated, %Outage{}}
    * {:deleted, %Outage{}}

  """
  def subscribe_outages(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Beacon.PubSub, "user:#{key}:outages")
  end

  defp broadcast_outage(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Beacon.PubSub, "user:#{key}:outages", message)
  end

  @doc """
  Returns the list of outages.

  ## Examples

      iex> list_outages(scope)
      [%Outage{}, ...]

  """
  def list_outages() do
    Repo.all(Outage)
  end

  @doc """
  Gets a single outage.

  Raises `Ecto.NoResultsError` if the Outage does not exist.

  ## Examples

      iex> get_outage!(scope, 123)
      %Outage{}

      iex> get_outage!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_outage!(id) do
    Repo.get!(Outage, id)
  end

  @spec create_outage(
          %Beacon.Accounts.Scope{optional(any()) => any()},
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  @doc """
  Creates a outage.

  ## Examples

      iex> create_outage(scope, %{field: value})
      {:ok, %Outage{}}

      iex> create_outage(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outage(%Scope{} = scope, attrs) do
    with {:ok, outage = %Outage{}} <-
           %Outage{}
           |> Outage.create_changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_outage(scope, {:created, outage})
      {:ok, outage}
    end
  end

  @doc """
  Updates a outage.

  ## Examples

      iex> update_outage(scope, outage, %{field: new_value})
      {:ok, %Outage{}}

      iex> update_outage(scope, outage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outage(%Scope{} = scope, %Outage{} = outage, attrs) do
    # true = outage.user_id == scope.user.id

    with {:ok, outage = %Outage{}} <-
           outage
           |> Outage.update_changeset(attrs, scope)
           |> Repo.update() do
      broadcast_outage(scope, {:updated, outage})
      {:ok, outage}
    end
  end

  @doc """
  Deletes a outage.

  ## Examples

      iex> delete_outage(scope, outage)
      {:ok, %Outage{}}

      iex> delete_outage(scope, outage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outage(%Scope{} = scope, %Outage{} = outage) do
    # true = outage.user_id == scope.user.id

    with {:ok, outage = %Outage{}} <-
           Repo.delete(outage) do
      broadcast_outage(scope, {:deleted, outage})
      {:ok, outage}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outage changes.

  ## Examples

      iex> change_outage(scope, outage)
      %Ecto.Changeset{data: %Outage{}}

  """
  def change_outage(%Scope{} = scope, %Outage{} = outage, attrs \\ %{}) do
    # true = outage.user_id == scope.user.id

    Outage.update_changeset(outage, attrs, scope)
  end
end
