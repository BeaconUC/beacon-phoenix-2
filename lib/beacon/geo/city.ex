defmodule Beacon.Geo.City do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "geo"

  schema "cities" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :boundary, Geo.PostGIS.Geometry

    field :name, :string
    field :population, :integer
    field :population_year, :integer

    belongs_to :province, Beacon.Geo.Province

    # has_many :barangays, Beacon.Geo.Barangay

    timestamps()
  end

  @required_fields [
    :public_id,
    :boundary,
    :name,
    :province_id,
    :population,
    :population_year
  ]
  def changeset(city, attrs) do
    city
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:population, greater_than_or_equal_to: 0)
    |> validate_number(:population_year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_length(:name, max: Constant.varchar_max_length())
    |> foreign_key_constraint(:province_id)
    |> unique_constraint(:public_id, name: :cities_public_id_idx)
  end
end
