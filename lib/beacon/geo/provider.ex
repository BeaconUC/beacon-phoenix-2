defmodule Beacon.Geo.Provider do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "geo"

  schema "providers" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true
    field :name, :string
    field :acronym, :string

    has_many :feeders, Beacon.Geo.Feeder

    timestamps()
  end

  @required_fields [
    :public_id,
    :name,
    :acronym
  ]
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name, name: :providers_name_idx)
    |> unique_constraint(:public_id, name: :providers_public_id_idx)
  end
end
