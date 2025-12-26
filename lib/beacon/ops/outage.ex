defmodule Beacon.Ops.Outage do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Ops.Outage

  @schema_prefix "ops"

  schema "outages" do

    field :public_id, Ecto.UUID, autogenerate: true
    field :outage_type, Ecto.Enum,
      values: [:unscheduled, :scheduled, :emergency]
    field :status, Ecto.Enum,
      values: [:unverified, :verified, :being_resolved, :resolved]
    field :confidence_percentage, :float
    field :title, :string
    field :description, :string
    field :number_of_reports, :integer
    field :estimated_affected_population, :integer
    field :start_time, :utc_datetime
    field :estimated_restoration_time, :utc_datetime
    field :actual_restoration_time, :utc_datetime

    belongs_to :provider, Beacon.Geo.Provider
    belongs_to :created_by, Beacon.Iam.Profile
    belongs_to :updated_by, Beacon.Iam.Profile
    belongs_to :confirmed_by, Beacon.Iam.Profile
    belongs_to :resolved_by, Beacon.Iam.Profile

    timestamps()
  end

  def create_changeset(%Outage{} = outage, attrs, scope) do
    outage
    |> cast(attrs, [
      :outage_type,
      :title,
      :description,
      :provider_id,
      :start_time
    ])
    |> validate_required([:outage_type, :provider_id])
    |> put_change(:created_by_id, scope.profile.id)
    |> put_change(:updated_by_id, scope.profile.id)
  end

  def update_changeset(outage, attrs, scope) do
    outage
    |> cast(attrs, [
      :status,
      :confidence_percentage,
      :description,
      :estimated_restoration_time,
      :actual_restoration_time
    ])
    |> put_change(:updated_by_id, scope.profile.id)
  end
end
