defmodule Beacon.Ops.Announcement do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "announcements" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :title, :string
    field :description, :string
    field :is_urgent, :boolean

    field :valid_from, :utc_datetime
    field :valid_until, :utc_datetime

    belongs_to :created_by_profile, Beacon.Iam.Profile, foreign_key: :created_by
    belongs_to :updated_by_profile, Beacon.Iam.Profile, foreign_key: :updated_by

    # has_many :announcement_scopes, Beacon.Ops.AnnouncementScope

    timestamps()
  end

   @required_fields [
    :public_id,
    :title,
    :description,
    :is_urgent,
    :valid_from,
    :created_by_id,
    :updated_by_id
  ]
  @optional_fields [
    :valid_until
  ]
  def changeset(announcement, attrs) do
    announcement
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 6)
    |> validate_length(:description, min: 11)
    |> validate_validity_range()
    |> foreign_key_constraint(:created_by_id)
    |> foreign_key_constraint(:updated_by_id)
    |> unique_constraint(:public_id, name: :announcements_public_id_idx)
  end

  defp validate_validity_range(changeset) do
    valid_from = get_field(changeset, :valid_from)
    valid_until = get_field(changeset, :valid_until)

    cond do
      is_nil(valid_until) or is_nil(valid_from) ->
        changeset

      DateTime.compare(valid_until, valid_from) == :gt ->
        changeset

      true ->
        add_error(
          changeset,
          :valid_until,
          "must be later than valid_from"
        )
    end
  end
end
