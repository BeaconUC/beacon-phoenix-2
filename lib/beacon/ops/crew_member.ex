defmodule Beacon.Ops.CrewMember do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "crew_members" do
    field :joined_at, :utc_datetime

    belongs_to :crew, Beacon.Ops.Crew
    belongs_to :profile, Beacon.Iam.Profile

    timestamps()
  end

  @required_fields [
    :crew_id,
    :profile_id,
    :joined_at
  ]
  def changeset(crew_member, attrs) do
    crew_member
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:crew_id)
    |> foreign_key_constraint(:profile_id)
    |> unique_constraint(
      [:crew_id, :profile_id],
      name: :crew_members_crew_id_profile_id_idx
    )
  end
end
