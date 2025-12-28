defmodule Beacon.Ops do
  @moduledoc """
  The Ops context.
  """

  import Ecto.Query, warn: false
  alias Beacon.Repo

  alias Beacon.Ops.Outage
  alias Beacon.Iam.Profile

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
    |> Ecto.Changeset.put_change(:created_by, profile.id)
    |> Ecto.Changeset.put_change(:updated_by, profile.id)
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
  def update_outage(%Profile{} = profile, %Outage{} = outage, attrs) do
    outage
    |> Outage.update_changeset(attrs)
    |> Ecto.Changeset.put_change(:updated_by, profile.id)
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

  alias Beacon.Ops.OutageUpdate

  @doc """
  Returns the list of outage_updates.

  ## Examples

      iex> list_outage_updates()
      [%OutageUpdate{}, ...]

  """
  def list_outage_updates do
    Repo.all(OutageUpdate)
  end

  @doc """
  Gets a single outage_update.

  Raises `Ecto.NoResultsError` if the Outage update does not exist.

  ## Examples

      iex> get_outage_update!(123)
      %OutageUpdate{}

      iex> get_outage_update!(456)
      ** (Ecto.NoResultsError)

  """
  def get_outage_update!(id), do: Repo.get!(OutageUpdate, id)

  @doc """
  Creates a outage_update.

  ## Examples

      iex> create_outage_update(%{field: value})
      {:ok, %OutageUpdate{}}

      iex> create_outage_update(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outage_update(attrs) do
    %OutageUpdate{}
    |> OutageUpdate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a outage_update.

  ## Examples

      iex> update_outage_update(outage_update, %{field: new_value})
      {:ok, %OutageUpdate{}}

      iex> update_outage_update(outage_update, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outage_update(%OutageUpdate{} = outage_update, attrs) do
    outage_update
    |> OutageUpdate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a outage_update.

  ## Examples

      iex> delete_outage_update(outage_update)
      {:ok, %OutageUpdate{}}

      iex> delete_outage_update(outage_update)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outage_update(%OutageUpdate{} = outage_update) do
    Repo.delete(outage_update)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outage_update changes.

  ## Examples

      iex> change_outage_update(outage_update)
      %Ecto.Changeset{data: %OutageUpdate{}}

  """
  def change_outage_update(%OutageUpdate{} = outage_update, attrs \\ %{}) do
    OutageUpdate.changeset(outage_update, attrs)
  end

  alias Beacon.Ops.OutageReport

  @doc """
  Returns the list of outage_reports.

  ## Examples

      iex> list_outage_reports()
      [%OutageReport{}, ...]

  """
  def list_outage_reports do
    Repo.all(OutageReport)
  end

  @doc """
  Gets a single outage_report.

  Raises `Ecto.NoResultsError` if the Outage report does not exist.

  ## Examples

      iex> get_outage_report!(123)
      %OutageReport{}

      iex> get_outage_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_outage_report!(id), do: Repo.get!(OutageReport, id)

  @doc """
  Creates a outage_report.

  ## Examples

      iex> create_outage_report(%{field: value})
      {:ok, %OutageReport{}}

      iex> create_outage_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outage_report(attrs) do
    %OutageReport{}
    |> OutageReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a outage_report.

  ## Examples

      iex> update_outage_report(outage_report, %{field: new_value})
      {:ok, %OutageReport{}}

      iex> update_outage_report(outage_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outage_report(%OutageReport{} = outage_report, attrs) do
    outage_report
    |> OutageReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a outage_report.

  ## Examples

      iex> delete_outage_report(outage_report)
      {:ok, %OutageReport{}}

      iex> delete_outage_report(outage_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outage_report(%OutageReport{} = outage_report) do
    Repo.delete(outage_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outage_report changes.

  ## Examples

      iex> change_outage_report(outage_report)
      %Ecto.Changeset{data: %OutageReport{}}

  """
  def change_outage_report(%OutageReport{} = outage_report, attrs \\ %{}) do
    OutageReport.changeset(outage_report, attrs)
  end

  alias Beacon.Ops.Assignment

  @doc """
  Returns the list of assignments.

  ## Examples

      iex> list_assignments()
      [%Assignment{}, ...]

  """
  def list_assignments do
    Repo.all(Assignment)
  end

  @doc """
  Gets a single assignment.

  Raises `Ecto.NoResultsError` if the Assignment does not exist.

  ## Examples

      iex> get_assignment!(123)
      %Assignment{}

      iex> get_assignment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assignment!(id), do: Repo.get!(Assignment, id)

  @doc """
  Creates a assignment.

  ## Examples

      iex> create_assignment(%{field: value})
      {:ok, %Assignment{}}

      iex> create_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assignment(attrs) do
    %Assignment{}
    |> Assignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assignment.

  ## Examples

      iex> update_assignment(assignment, %{field: new_value})
      {:ok, %Assignment{}}

      iex> update_assignment(assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assignment(%Assignment{} = assignment, attrs) do
    assignment
    |> Assignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assignment.

  ## Examples

      iex> delete_assignment(assignment)
      {:ok, %Assignment{}}

      iex> delete_assignment(assignment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assignment(%Assignment{} = assignment) do
    Repo.delete(assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assignment changes.

  ## Examples

      iex> change_assignment(assignment)
      %Ecto.Changeset{data: %Assignment{}}

  """
  def change_assignment(%Assignment{} = assignment, attrs \\ %{}) do
    Assignment.changeset(assignment, attrs)
  end

  alias Beacon.Ops.Crew

  @doc """
  Returns the list of crews.

  ## Examples

      iex> list_crews()
      [%Crew{}, ...]

  """
  def list_crews do
    Repo.all(Crew)
  end

  @doc """
  Gets a single crew.

  Raises `Ecto.NoResultsError` if the Crew does not exist.

  ## Examples

      iex> get_crew!(123)
      %Crew{}

      iex> get_crew!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crew!(id), do: Repo.get!(Crew, id)

  @doc """
  Creates a crew.

  ## Examples

      iex> create_crew(%{field: value})
      {:ok, %Crew{}}

      iex> create_crew(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crew(attrs) do
    %Crew{}
    |> Crew.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crew.

  ## Examples

      iex> update_crew(crew, %{field: new_value})
      {:ok, %Crew{}}

      iex> update_crew(crew, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crew(%Crew{} = crew, attrs) do
    crew
    |> Crew.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a crew.

  ## Examples

      iex> delete_crew(crew)
      {:ok, %Crew{}}

      iex> delete_crew(crew)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crew(%Crew{} = crew) do
    Repo.delete(crew)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crew changes.

  ## Examples

      iex> change_crew(crew)
      %Ecto.Changeset{data: %Crew{}}

  """
  def change_crew(%Crew{} = crew, attrs \\ %{}) do
    Crew.changeset(crew, attrs)
  end

  alias Beacon.Ops.CrewMember

  @doc """
  Returns the list of crew_members.

  ## Examples

      iex> list_crew_members()
      [%CrewMember{}, ...]

  """
  def list_crew_members do
    Repo.all(CrewMember)
  end

  @doc """
  Gets a single crew_member.

  Raises `Ecto.NoResultsError` if the Crew member does not exist.

  ## Examples

      iex> get_crew_member!(123)
      %CrewMember{}

      iex> get_crew_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crew_member!(id), do: Repo.get!(CrewMember, id)

  @doc """
  Creates a crew_member.

  ## Examples

      iex> create_crew_member(%{field: value})
      {:ok, %CrewMember{}}

      iex> create_crew_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crew_member(attrs) do
    %CrewMember{}
    |> CrewMember.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crew_member.

  ## Examples

      iex> update_crew_member(crew_member, %{field: new_value})
      {:ok, %CrewMember{}}

      iex> update_crew_member(crew_member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crew_member(%CrewMember{} = crew_member, attrs) do
    crew_member
    |> CrewMember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a crew_member.

  ## Examples

      iex> delete_crew_member(crew_member)
      {:ok, %CrewMember{}}

      iex> delete_crew_member(crew_member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crew_member(%CrewMember{} = crew_member) do
    Repo.delete(crew_member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crew_member changes.

  ## Examples

      iex> change_crew_member(crew_member)
      %Ecto.Changeset{data: %CrewMember{}}

  """
  def change_crew_member(%CrewMember{} = crew_member, attrs \\ %{}) do
    CrewMember.changeset(crew_member, attrs)
  end

  alias Beacon.Ops.Announcement

  @doc """
  Returns the list of announcements.

  ## Examples

      iex> list_announcements()
      [%Announcement{}, ...]

  """
  def list_announcements do
    Repo.all(Announcement)
  end

  @doc """
  Gets a single announcement.

  Raises `Ecto.NoResultsError` if the Announcement does not exist.

  ## Examples

      iex> get_announcement!(123)
      %Announcement{}

      iex> get_announcement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_announcement!(id), do: Repo.get!(Announcement, id)

  @doc """
  Creates a announcement.

  ## Examples

      iex> create_announcement(%{field: value})
      {:ok, %Announcement{}}

      iex> create_announcement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_announcement(attrs) do
    %Announcement{}
    |> Announcement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a announcement.

  ## Examples

      iex> update_announcement(announcement, %{field: new_value})
      {:ok, %Announcement{}}

      iex> update_announcement(announcement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_announcement(%Announcement{} = announcement, attrs) do
    announcement
    |> Announcement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a announcement.

  ## Examples

      iex> delete_announcement(announcement)
      {:ok, %Announcement{}}

      iex> delete_announcement(announcement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_announcement(%Announcement{} = announcement) do
    Repo.delete(announcement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking announcement changes.

  ## Examples

      iex> change_announcement(announcement)
      %Ecto.Changeset{data: %Announcement{}}

  """
  def change_announcement(%Announcement{} = announcement, attrs \\ %{}) do
    Announcement.changeset(announcement, attrs)
  end

  alias Beacon.Ops.AnnouncementScope

  @doc """
  Returns the list of announcement_scopes.

  ## Examples

      iex> list_announcement_scopes()
      [%AnnouncementScope{}, ...]

  """
  def list_announcement_scopes do
    Repo.all(AnnouncementScope)
  end

  @doc """
  Gets a single announcement_scope.

  Raises `Ecto.NoResultsError` if the Announcement scope does not exist.

  ## Examples

      iex> get_announcement_scope!(123)
      %AnnouncementScope{}

      iex> get_announcement_scope!(456)
      ** (Ecto.NoResultsError)

  """
  def get_announcement_scope!(id), do: Repo.get!(AnnouncementScope, id)

  @doc """
  Creates a announcement_scope.

  ## Examples

      iex> create_announcement_scope(%{field: value})
      {:ok, %AnnouncementScope{}}

      iex> create_announcement_scope(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_announcement_scope(attrs) do
    %AnnouncementScope{}
    |> AnnouncementScope.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a announcement_scope.

  ## Examples

      iex> update_announcement_scope(announcement_scope, %{field: new_value})
      {:ok, %AnnouncementScope{}}

      iex> update_announcement_scope(announcement_scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_announcement_scope(%AnnouncementScope{} = announcement_scope, attrs) do
    announcement_scope
    |> AnnouncementScope.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a announcement_scope.

  ## Examples

      iex> delete_announcement_scope(announcement_scope)
      {:ok, %AnnouncementScope{}}

      iex> delete_announcement_scope(announcement_scope)
      {:error, %Ecto.Changeset{}}

  """
  def delete_announcement_scope(%AnnouncementScope{} = announcement_scope) do
    Repo.delete(announcement_scope)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking announcement_scope changes.

  ## Examples

      iex> change_announcement_scope(announcement_scope)
      %Ecto.Changeset{data: %AnnouncementScope{}}

  """
  def change_announcement_scope(%AnnouncementScope{} = announcement_scope, attrs \\ %{}) do
    AnnouncementScope.changeset(announcement_scope, attrs)
  end

  alias Beacon.Ops.AffectedArea

  @doc """
  Returns the list of affected_areas.

  ## Examples

      iex> list_affected_areas()
      [%AffectedArea{}, ...]

  """
  def list_affected_areas do
    Repo.all(AffectedArea)
  end

  @doc """
  Gets a single affected_area.

  Raises `Ecto.NoResultsError` if the Affected area does not exist.

  ## Examples

      iex> get_affected_area!(123)
      %AffectedArea{}

      iex> get_affected_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_affected_area!(id), do: Repo.get!(AffectedArea, id)

  @doc """
  Creates a affected_area.

  ## Examples

      iex> create_affected_area(%{field: value})
      {:ok, %AffectedArea{}}

      iex> create_affected_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_affected_area(attrs) do
    %AffectedArea{}
    |> AffectedArea.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a affected_area.

  ## Examples

      iex> update_affected_area(affected_area, %{field: new_value})
      {:ok, %AffectedArea{}}

      iex> update_affected_area(affected_area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_affected_area(%AffectedArea{} = affected_area, attrs) do
    affected_area
    |> AffectedArea.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a affected_area.

  ## Examples

      iex> delete_affected_area(affected_area)
      {:ok, %AffectedArea{}}

      iex> delete_affected_area(affected_area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_affected_area(%AffectedArea{} = affected_area) do
    Repo.delete(affected_area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking affected_area changes.

  ## Examples

      iex> change_affected_area(affected_area)
      %Ecto.Changeset{data: %AffectedArea{}}

  """
  def change_affected_area(%AffectedArea{} = affected_area, attrs \\ %{}) do
    AffectedArea.changeset(affected_area, attrs)
  end
end
