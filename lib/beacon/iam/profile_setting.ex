defmodule Beacon.Iam.ProfileSetting do
  use Beacon.Schema
  import Ecto.Changeset

  schema "profile_settings" do
    field :theme, Ecto.Enum, values: [:system, :light, :dark]
    field :dynamic_color, :boolean
    field :font_scale, :decimal
    field :reduce_motion, :boolean
    field :language, :string
    field :extra_settings, :map

    belongs_to :profile, Beacon.Iam.Profile

    timestamps()
  end

  @required_fields [
    :profile_id,
    :theme,
    :dynamic_color,
    :font_scale,
    :reduce_motion,
    :language,
    :extra_settings
  ]
  def changeset(profile_setting, attrs) do
    profile_setting
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:font_scale,
      greater_than_or_equal_to: 0.75,
      less_than_or_equal_to: 1.50
    )
    |> validate_length(:language, max: 10)
    |> foreign_key_constraint(:profile_id)
    |> unique_constraint(:profile_id, name: :profile_settings_profile_id_idx)
  end
end
