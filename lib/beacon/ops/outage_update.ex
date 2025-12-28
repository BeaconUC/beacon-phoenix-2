defmodule Beacon.Ops.OutageUpdate do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "outage_updates" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :old_status, Ecto.Enum,
      values: [:reported, :confirmed, :in_progress, :resolved, :cancelled]

    field :new_status, Ecto.Enum,
      values: [:reported, :confirmed, :in_progress, :resolved, :cancelled]

    field :description, :string

    belongs_to :outage, Beacon.Ops.Outage
    belongs_to :created_by, Beacon.Iam.Profile
    belongs_to :updated_by, Beacon.Iam.Profile

    timestamps()
  end

  @required_fields [
    :public_id,
    :outage_id,
    :old_status,
    :new_status,
    :created_by_id,
    :updated_by_id
  ]
  @optional_fields [
    :description
  ]
  def changeset(outage_update, attrs) do
    outage_update
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    # |> validate_status_change()
    |> foreign_key_constraint(:outage_id)
    |> foreign_key_constraint(:created_by_id)
    |> foreign_key_constraint(:updated_by_id)
    |> unique_constraint(:public_id, name: :outage_updates_public_id_idx)
  end

  # defp validate_status_change(changeset) do
  #   old_status = get_field(changeset, :old_status)
  #   new_status = get_field(changeset, :new_status)

  #   cond do
  #     is_nil(old_status) or is_nil(new_status) ->
  #       changeset

  #     old_status != new_status ->
  #       changeset

  #     true ->
  #       add_error(
  #         changeset,
  #         :new_status,
  #         "must be different from old_status"
  #       )
  #   end
  # end
end
