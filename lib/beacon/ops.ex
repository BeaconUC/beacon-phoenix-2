defmodule Beacon.Ops do
  @moduledoc """
  The Ops context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Ops.Outage
  alias Beacon.Ops.OutageReport
  alias Beacon.Ops.Announcement
  alias Beacon.Ops.Assignment
  alias Beacon.Accounts.Scope

  @outage_report_topic "outage_reports"
  @outage_topic "outages"

  @doc """
  Subscribes to scoped notifications about any outage changes.
  """
  def subscribe_outage do
    Phoenix.PubSub.subscribe(Beacon.PubSub, @outage_topic)
  end

  def subscribe_outage(id) do
    Phoenix.PubSub.subscribe(Beacon.PubSub, "#{@outage_topic}:#{id}")
  end

  defp broadcast({:ok, outage}, event) when event in [:outage_created, :outage_updated, :outage_deleted] do
    Phoenix.PubSub.broadcast(Beacon.PubSub, @outage_topic, {event, outage})
    Phoenix.PubSub.broadcast(Beacon.PubSub, "#{@outage_topic}:#{outage.id}", {event, outage})

    {:ok, outage}
  end

  defp broadcast({:ok, outage_report}, event) when event in [:outage_report_created, :outage_report_updated, :outage_report_deleted] do
    Phoenix.PubSub.broadcast(Beacon.PubSub, @outage_report_topic, {event, outage_report})
    Phoenix.PubSub.broadcast(Beacon.PubSub, "#{@outage_report_topic}:#{outage_report.id}", {event, outage_report})

    {:ok, outage_report}
  end
  defp broadcast({:error, _} = error, _event), do: error

  @doc """
  Returns the list of outages.

  ## Examples

      iex> list_outages(scope)
      [%Outage{}, ...]

  """
  def list_outages(%Scope{} = _scope) do
    query = from o in Outage, order_by: [desc: o.updated_at], limit: 100
    Repo.all(query)
  end

  @doc """
  Gets a single outage.

  Raises if the Outage does not exist.

  ## Examples

      iex> get_outage!(scope, 123)
      %Outage{}

  """
  def get_outage!(%Scope{} = _scope, id) do
    Repo.get!(Outage, id)
  end

  @doc """
  Creates a outage.

  ## Examples

      iex> create_outage(scope, %{field: value})
      {:ok, %Outage{}}

      iex> create_outage(scope, %{field: bad_value})
      {:error, ...}

  """
  def create_outage(%Scope{role: :user} = scope, attrs) do
    attrs =
      attrs
      |> Map.put("created_by", scope.profile.id)
      |> Map.put("confidence_percentage", 100.0)
      |> Map.put("updated_by", scope.profile.id)
      |> Map.put("provider_id", 1)

    %Outage{}
    |> Outage.changeset(attrs)
    |> Repo.insert(returning: true)
    |> broadcast(:outage_created)
  end

  def create_outage(%Scope{}, _attrs) do
    {:error, :unauthorized}
  end

  @doc """
  Updates a outage.

  ## Examples

      iex> update_outage(scope, outage, %{field: new_value})
      {:ok, %Outage{}}

      iex> update_outage(scope, outage, %{field: bad_value})
      {:error, ...}

  """
  def update_outage(%Scope{role: :user} = scope, %Outage{} = outage, attrs) do
    attrs =
      attrs
      |> Map.put("updated_by", scope.profile.id)

    outage
    |> Outage.changeset(attrs)
    |> Repo.update()
    |> broadcast(:outage_updated)
  end

  def update_outage(%Scope{}, %Outage{}, _attrs) do
    {:error, :unauthorized}
  end

  def resolve_outage(%Scope{role: role} = scope, %Outage{} = outage, attrs) when role in [:user, :admin, :crew] do
    attrs =
      attrs
      |> Map.put("resolved_by", scope.profile.id)
      |> Map.put("updated_by", scope.profile.id)

    outage
    |> Outage.changeset(attrs)
    |> Repo.update()
    |> broadcast(:outage_resolved)
  end

  @doc """
  Deletes a Outage.

  ## Examples

      iex> delete_outage(scope, outage)
      {:ok, %Outage{}}

      iex> delete_outage(scope, outage)
      {:error, ...}

  """
  def delete_outage(%Scope{role: :user} = _scope, %Outage{} = outage) do
    Repo.delete(outage)
    |> broadcast(:outage_deleted)
  end

  def delete_outage(%Scope{}, %Outage{}) do
    {:error, :unauthorized}
  end

  @doc """
  Returns a data structure for tracking outage changes.

  ## Examples

      iex> change_outage(scope, outage)
      %Todo{...}

  """
  def change_outage(%Scope{} = _scope, %Outage{} = outage, attrs \\ %{}) do
    Outage.changeset(outage, attrs)
  end

  @doc """
  Subscribes to scoped notifications about any outage_report changes.
  """
  def subscribe_outage_reports(%Scope{} = _scope) do
    Phoenix.PubSub.subscribe(Beacon.PubSub, @outage_report_topic)
  end

  def subscribe_outage_reports(%Scope{} = _scope, id) do
    Phoenix.PubSub.subscribe(Beacon.PubSub, "#{@outage_report_topic}:#{id}")
  end

  @doc """
  Returns the list of outage_reports.

  ## Examples

      iex> list_outage_reports(scope)
      [%OutageReport{}, ...]

  """
  def list_outage_reports(%Scope{} = _scope) do
    query = from o in OutageReport, order_by: [desc: o.updated_at], limit: 100
    Repo.all(query)
  end

  @doc """
  Gets a single outage_report.

  Raises if the Outage report does not exist.

  ## Examples

      iex> get_outage_report!(scope, 123)
      %OutageReport{}

  """
  def get_outage_report!(%Scope{} = _scope, id) do
    Repo.get!(OutageReport, id)
  end

  @doc """
  Creates a outage_report.

  ## Examples

      iex> create_outage_report(scope, %{field: value})
      {:ok, %OutageReport{}}

      iex> create_outage_report(scope, %{field: bad_value})
      {:error, ...}

  """
  def create_outage_report(%Scope{} = scope, attrs, location) do
    attrs =
      attrs
      |> Map.put("reported_by", scope.profile.id)
      |> Map.put("location", location)

    %OutageReport{}
    |> OutageReport.changeset(attrs)
    |> Repo.insert(returning: true)
    |> broadcast(:outage_report_created)
  end

  @doc """
  Updates a outage_report.

  ## Examples

      iex> update_outage_report(scope, outage_report, %{field: new_value})
      {:ok, %OutageReport{}}

      iex> update_outage_report(scope, outage_report, %{field: bad_value})
      {:error, ...}

  """
  def update_outage_report(%Scope{} = scope, %OutageReport{} = outage_report, attrs) do
    is_admin = scope.role == :admin
    is_owner = scope.user && outage_report.reported_by == scope.profile.id

    if is_admin or is_owner do
      outage_report
      |> OutageReport.changeset(attrs)
      |> Repo.update()
      |> broadcast(:outage_report_updated)
    else
      {:error, :unauthorized}
    end
  end

  @doc """
  Deletes a OutageReport.

  ## Examples

      iex> delete_outage_report(scope, outage_report)
      {:ok, %OutageReport{}}

      iex> delete_outage_report(scope, outage_report)
      {:error, ...}

  """
  def delete_outage_report(%Scope{} = scope, %OutageReport{} = outage_report) do
    is_admin = scope.role == :admin
    is_owner = scope.user && outage_report.reported_by == scope.profile.id

    if is_admin or is_owner do
      Repo.delete(outage_report)
      |> broadcast(:outage_report_deleted)
    else
      {:error, :unauthorized}
    end
  end

  @doc """
  Returns a data structure for tracking outage_report changes.

  ## Examples

      iex> change_outage_report(scope, outage_report)
      %Todo{...}

  """
  def change_outage_report(%Scope{} = _scope, %OutageReport{} = outage_report, attrs \\ %{}) do
    OutageReport.changeset(outage_report, attrs)
  end

  @doc """
  Subscribes to scoped notifications about any announcement changes.
  """
  def subscribe_announcement(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Returns the list of announcements.

  ## Examples

      iex> list_announcements(scope)
      [%Announcement{}, ...]

  """
  def list_announcements(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Gets a single announcement.

  Raises if the Announcement does not exist.

  ## Examples

      iex> get_announcement!(scope, 123)
      %Announcement{}

  """
  def get_announcement!(%Scope{} = _scope, id), do: raise "TODO"

  @doc """
  Creates a announcement.

  ## Examples

      iex> create_announcement(scope, %{field: value})
      {:ok, %Announcement{}}

      iex> create_announcement(scope, %{field: bad_value})
      {:error, ...}

  """
  def create_announcement(%Scope{} = _scope, attrs) do
    raise "TODO"
  end

  @doc """
  Updates a announcement.

  ## Examples

      iex> update_announcement(scope, announcement, %{field: new_value})
      {:ok, %Announcement{}}

      iex> update_announcement(scope, announcement, %{field: bad_value})
      {:error, ...}

  """
  def update_announcement(%Scope{} = _scope, %Announcement{} = announcement, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Announcement.

  ## Examples

      iex> delete_announcement(scope, announcement)
      {:ok, %Announcement{}}

      iex> delete_announcement(scope, announcement)
      {:error, ...}

  """
  def delete_announcement(%Scope{} = _scope, %Announcement{} = announcement) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking announcement changes.

  ## Examples

      iex> change_announcement(scope, announcement)
      %Todo{...}

  """
  def change_announcement(%Scope{} = _scope, %Announcement{} = announcement, _attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Subscribes to scoped notifications about any assignment changes.
  """
  def subscribe_assignment(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Returns the list of assignments.

  ## Examples

      iex> list_assignments(scope)
      [%Assignment{}, ...]

  """
  def list_assignments(%Scope{} = _scope) do
    raise "TODO"
  end

  @doc """
  Gets a single assignment.

  Raises if the Assignment does not exist.

  ## Examples

      iex> get_assignment!(scope, 123)
      %Assignment{}

  """
  def get_assignment!(%Scope{} = _scope, id), do: raise "TODO"

  @doc """
  Creates a assignment.

  ## Examples

      iex> create_assignment(scope, %{field: value})
      {:ok, %Assignment{}}

      iex> create_assignment(scope, %{field: bad_value})
      {:error, ...}

  """
  def create_assignment(%Scope{} = _scope, attrs) do
    raise "TODO"
  end

  @doc """
  Updates a assignment.

  ## Examples

      iex> update_assignment(scope, assignment, %{field: new_value})
      {:ok, %Assignment{}}

      iex> update_assignment(scope, assignment, %{field: bad_value})
      {:error, ...}

  """
  def update_assignment(%Scope{} = _scope, %Assignment{} = assignment, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Assignment.

  ## Examples

      iex> delete_assignment(scope, assignment)
      {:ok, %Assignment{}}

      iex> delete_assignment(scope, assignment)
      {:error, ...}

  """
  def delete_assignment(%Scope{} = _scope, %Assignment{} = assignment) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking assignment changes.

  ## Examples

      iex> change_assignment(scope, assignment)
      %Todo{...}

  """
  def change_assignment(%Scope{} = _scope, %Assignment{} = assignment, _attrs \\ %{}) do
    raise "TODO"
  end
end
