defmodule Beacon.Geo.Feeder do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "geo"

  schema "feeders" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true
    field :boundary, Geo.PostGIS.Geometry
    field :feeder_number, :string

    belongs_to :provider, Beacon.Geo.Provider

    # has_many :barangay_feeders, Beacon.Geo.BarangayFeeder
    # has_many :barangays, through: [:barangay_feeders, :barangay]

    timestamps()
  end

  @required_fields [
    :public_id,
    :boundary,
    :provider_id,
    :feeder_number
  ]
  def changeset(feeder, attrs) do
    feeder
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:provider_id)
    |> validate_length(:feeder_number, max: 20)
    |> unique_constraint(:public_id, name: :feeders_public_id_idx)
    |> unique_constraint(
      [:provider_id, :feeder_number],
      name: :feeders_provider_id_feeder_number_idx
    )
  end
end
