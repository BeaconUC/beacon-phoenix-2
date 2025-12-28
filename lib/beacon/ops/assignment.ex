defmodule Beacon.Ops.Assignment do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "assignments" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :status, Ecto.Enum,
      values: [:assigned, :in_progress, :completed, :terminated]

    field :notes, :string
    field :terminated_at, :utc_datetime

    belongs_to :outage, Beacon.Ops.Outage
    belongs_to :crew, Beacon.Ops.Crew

    belongs_to :created_by_profile, Beacon.Iam.Profile, foreign_key: :created_by
    belongs_to :updated_by_profile, Beacon.Iam.Profile, foreign_key: :updated_by

    timestamps()
  end

  @required_fields [
    :public_id,
    :outage_id,
    :crew_id,
    :status,
    :created_by_id,
    :updated_by_id
  ]
  @optional_fields [
    :notes,
    :terminated_at
  ]
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_termination_timeline()
    |> foreign_key_constraint(:outage_id)
    |> foreign_key_constraint(:crew_id)
    |> foreign_key_constraint(:created_by_id)
    |> foreign_key_constraint(:updated_by_id)
    |> unique_constraint(:public_id, name: :assignments_public_id_idx)
    |> unique_constraint(
      [:outage_id, :crew_id],
      name: :uk_active_assignment,
      where: [terminated_at: nil]
    )
  end

  defp validate_termination_timeline(changeset) do
    terminated_at = get_field(changeset, :terminated_at)
    created_at = get_field(changeset, :created_at)

    cond do
      is_nil(terminated_at) or is_nil(created_at) ->
        changeset

      DateTime.compare(terminated_at, created_at) in [:gt, :eq] ->
        changeset

      true ->
        add_error(
          changeset,
          :terminated_at,
          "must be greater than or equal to created_at"
        )
    end
  end
end
