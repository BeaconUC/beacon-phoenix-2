defmodule Beacon.Ops.AnnouncementScope do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "ops"

  schema "announcement_scopes" do
    belongs_to :announcement, Beacon.Ops.Announcement

    belongs_to :province, Beacon.Geo.Province
    belongs_to :city, Beacon.Geo.City
    belongs_to :barangay, Beacon.Geo.Barangay
    belongs_to :feeder, Beacon.Geo.Feeder
    belongs_to :outage, Beacon.Ops.Outage

    timestamps()
  end

  @required_fields [:announcement_id]
  @scope_fields [
    :province_id,
    :city_id,
    :barangay_id,
    :feeder_id,
    :outage_id
  ]
  def changeset(announcement_scope, attrs) do
    announcement_scope
    |> cast(attrs, @required_fields ++ @scope_fields)
    |> validate_required(@required_fields)
    |> validate_exactly_one_scope()
    |> foreign_key_constraint(:announcement_id)
    |> foreign_key_constraint(:province_id)
    |> foreign_key_constraint(:city_id)
    |> foreign_key_constraint(:barangay_id)
    |> foreign_key_constraint(:feeder_id)
    |> foreign_key_constraint(:outage_id)
    |> unique_constraint(
      [
        :announcement_id,
        :province_id,
        :city_id,
        :barangay_id,
        :feeder_id,
        :outage_id
      ],
      name: :announcement_scopes_announcement_id_province_id_city_id_bar_idx
    )
  end

  defp validate_exactly_one_scope(changeset) do
    count =
      @scope_fields
      |> Enum.count(fn field ->
        not is_nil(get_field(changeset, field))
      end)

    if count == 1 do
      changeset
    else
      add_error(
        changeset,
        :base,
        "exactly one scope must be set (province, city, barangay, feeder, or outage)"
      )
    end
  end
end
