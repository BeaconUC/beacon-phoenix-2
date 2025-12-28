defmodule Beacon.Ops.Crew do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "crews" do
    field :public_id, Ecto.UUID
    field :name, :string
    field :description, :string

    has_many :crew_members, Beacon.Ops.CrewMember
    has_many :profiles, through: [:crew_members, :profile]

    has_many :assignments, Beacon.Ops.Assignment

    timestamps()
  end

  @required_fields [
    :public_id,
    :name
  ]
  @optional_fields [
    :description
  ]
  def changeset(crew, attrs) do
    crew
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, max: 255)
    |> unique_constraint(:public_id, name: :crews_public_id_idx)
  end
end
