defmodule Beacon.Geo.Region do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "geo"

  schema "regions" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :name, :string
    field :acronym, :string
    field :rom_code, :string

    field :boundary, Geo.PostGIS.Geometry

    # has_many :provinces, Beacon.Geo.Province

    timestamps()
  end

  @required_fields [
    :public_id,
    :name,
    :acronym,
    :rom_code,
    :boundary
  ]
  def changeset(region, attrs) do
    region
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, max: Constant.varchar_max_length())
    |> validate_length(:acronym, max: 20)
    |> validate_length(:rom_code, max: 20)
    |> unique_constraint(:name, name: :regions_name_idx)
    |> unique_constraint(:acronym, name: :regions_acronym_idx)
    |> unique_constraint(:rom_code, name: :regions_rom_code_idx)
    |> unique_constraint(:public_id, name: :regions_public_id_idx)
  end
end
