defmodule Beacon.Geo.BarangayFeeder do
  use Beacon.Schema
  import Ecto.Changeset

  schema "barangay_feeders" do
    belongs_to :barangay, Beacon.Geo.Barangay
    belongs_to :feeder, Beacon.Geo.Feeder

    timestamps()
  end

  @required_fields [:barangay_id, :feeder_id]
  def changeset(barangay_feeder, attrs) do
    barangay_feeder
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:barangay_id)
    |> foreign_key_constraint(:feeder_id)
    |> unique_constraint(
      [:barangay_id, :feeder_id],
      name: :barangay_feeders_barangay_id_feeder_id_idx
    )
  end
end
