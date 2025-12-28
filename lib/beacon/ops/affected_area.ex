defmodule Beacon.Ops.AffectedArea do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "affected_areas" do
    belongs_to :outage, Beacon.Ops.Outage
    belongs_to :barangay, Beacon.Geo.Barangay

    timestamps()
  end

  @required_fields [
    :outage_id,
    :barangay_id
  ]
  def changeset(affected_area, attrs) do
    affected_area
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:outage_id)
    |> foreign_key_constraint(:barangay_id)
    |> unique_constraint(
      [:outage_id, :barangay_id],
      name: :affected_areas_outage_id_barangay_id_idx
    )
  end
end
