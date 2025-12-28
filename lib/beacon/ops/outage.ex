defmodule Beacon.Ops.Outage do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "outages" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :outage_type, Ecto.Enum,
      values: [:unscheduled, :scheduled, :emergency]

    field :status, Ecto.Enum,
      values: [:unverified, :reported, :confirmed, :in_progress, :resolved, :cancelled]

    field :confidence_percentage, :float

    field :title, :string
    field :description, :string

    field :number_of_reports, :integer
    field :estimated_affected_population, :integer

    field :start_time, :utc_datetime
    field :estimated_restoration_time, :utc_datetime
    field :actual_restoration_time, :utc_datetime

    belongs_to :provider, Beacon.Geo.Provider

    belongs_to :confirmed_by, Beacon.Iam.Profile
    belongs_to :resolved_by, Beacon.Iam.Profile
    belongs_to :created_by, Beacon.Iam.Profile
    belongs_to :updated_by, Beacon.Iam.Profile

    has_many :affected_areas, Beacon.Ops.AffectedArea
    has_many :barangays, through: [:affected_areas, :barangay]

    has_many :assignments, Beacon.Ops.Assignment
    has_many :outage_updates, Beacon.Ops.OutageUpdate
    has_many :outage_reports, Beacon.Ops.OutageReport

    timestamps()
  end

  @required_fields [
    :public_id,
    :provider_id,
    :number_of_reports,
    :estimated_affected_population,
    :created_by_id,
    :updated_by_id
  ]
  @optional_fields [
    :outage_type,
    :status,
    :confidence_percentage,
    :title,
    :description,
    :start_time,
    :estimated_restoration_time,
    :actual_restoration_time,
    :confirmed_by_id,
    :resolved_by_id
  ]
  def changeset(outage, attrs) do
    outage
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:confidence_percentage, 0..100)
    |> validate_number(:number_of_reports, greater_than_or_equal_to: 0)
    |> validate_number(:estimated_affected_population, greater_than_or_equal_to: 0)
    |> validate_restoration_timelines()
    |> foreign_key_constraint(:provider_id)
    |> foreign_key_constraint(:created_by_id)
    |> foreign_key_constraint(:updated_by_id)
    |> foreign_key_constraint(:confirmed_by_id)
    |> foreign_key_constraint(:resolved_by_id)
    |> unique_constraint(:public_id, name: :outages_public_id_idx)
  end

  defp validate_restoration_timelines(changeset) do
    start_time = get_field(changeset, :start_time)
    est = get_field(changeset, :estimated_restoration_time)
    act = get_field(changeset, :actual_restoration_time)

    changeset
    |> maybe_validate_after(:estimated_restoration_time, est, start_time)
    |> maybe_validate_after(:actual_restoration_time, act, start_time)
  end

  defp maybe_validate_after(changeset, _field, nil, _start), do: changeset
  defp maybe_validate_after(changeset, _field, _value, nil), do: changeset

  defp maybe_validate_after(changeset, field, value, start_time) do
    if DateTime.compare(value, start_time) in [:gt, :eq] do
      changeset
    else
      add_error(
        changeset,
        field,
        "must be greater than or equal to start_time"
      )
    end
  end
end
