defmodule Beacon.Geo.Province do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "geo"

  schema "provinces" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true
    field :boundary, Geo.PostGIS.Geometry

    field :name, :string
    field :population, :integer
    field :population_year, :integer

    belongs_to :region, Beacon.Geo.Region

    has_many :cities, Beacon.Geo.City

    timestamps()
  end

  @required_fields [
    :public_id,
    :boundary,
    :region_id,
    :name,
    :population,
    :population_year
  ]
  def changeset(province, attrs) do
    province
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:population, greater_than_or_equal_to: 0)
    |> validate_number(:population_year, greater_than_or_equal_to: 2020)
    |> foreign_key_constraint(:region_id)
    |> unique_constraint(:name, name: :provinces_name_idx)
    |> unique_constraint(:public_id, name: :provinces_public_id_idx)
  end
end
