defmodule Beacon.Geo.Barangay do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "geo"

  schema "barangays" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :boundary, Geo.PostGIS.Geometry
    field :center, Geo.PostGIS.Geometry

    field :name, :string
    field :population, :integer
    field :population_year, :integer
    field :cluster_id, :integer

    belongs_to :city, Beacon.Geo.City
    # has_many :barangay_feeders, Beacon.Geo.BarangayFeeder
    # has_many :feeders, through: [:barangay_feeders, :feeder]

    timestamps()
  end

  @required_fields [
    :public_id,
    :boundary,
    :name,
    :city_id,
    :population,
    :population_year
  ]
  @optional_fields [
    :cluster_id
  ]
  def changeset(barangay, attrs) do
    barangay
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:population, greater_than_or_equal_to: 0)
    |> validate_number(:population_year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_length(:name, max: Constant.varchar_max_length())
    |> foreign_key_constraint(:city_id)
    |> unique_constraint(:public_id, name: :barangays_public_id_idx)
    |> unique_constraint([:city_id, :name], name: :barangays_city_id_name_idx)
  end
end
