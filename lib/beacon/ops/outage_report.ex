defmodule Beacon.Ops.OutageReport do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "outage_reports" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :location, Geo.PostGIS.Geometry
    field :description, :string
    field :image_url, :string

    field :status, Ecto.Enum,
      values: [:unprocessed, :validated, :linked, :dismissed]

    belongs_to :reported_by, Beacon.Iam.Profile
    belongs_to :linked_outage, Beacon.Ops.Outage
    belongs_to :barangay, Beacon.Geo.Barangay

    timestamps()
  end

  @required_fields [
    :public_id,
    :location,
    :status
  ]
  @optional_fields [
    :description,
    :image_url,
    :reported_by_id,
    :linked_outage_id,
    :barangay_id
  ]
  def changeset(outage_report, attrs) do
    outage_report
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:reported_by_id)
    |> foreign_key_constraint(:linked_outage_id)
    |> foreign_key_constraint(:barangay_id)
    |> unique_constraint(:public_id, name: :outage_reports_public_id_idx)
  end
end
