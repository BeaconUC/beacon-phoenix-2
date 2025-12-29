defmodule Beacon.Iam.Profile do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.{ Constant, Enum }

  @schema_prefix "iam"

  schema "profiles" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :first_name, :string
    field :last_name, :string

    field :role, Ecto.Enum, values: Enum.roles_values()
    field :phone_number, :string

    belongs_to :user, Beacon.Accounts.User

    # has_one :profile_settings, Beacon.Iam.ProfileSetting
    # has_many :created_api_keys, Beacon.Iam.ApiKey, foreign_key: :created_by
    # has_many :updated_api_keys, Beacon.Iam.ApiKey, foreign_key: :updated_by

    timestamps()
  end

  @required_fields [
    :public_id,
    :role
  ]

  @optional_fields [
    :first_name,
    :last_name,
    :phone_number,
    :user_id
  ]
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:phone_number, max: 20)
    |> validate_names_if_present()
    |> validate_length(:first_name, max: Constant.varchar_max_length())
    |> validate_length(:last_name, max: Constant.varchar_max_length())
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:user_id, name: :profiles_user_id_uk)
    |> unique_constraint(:public_id, name: :profiles_public_id_idx)
  end

  defp validate_names_if_present(changeset) do
    first = get_field(changeset, :first_name)
    last = get_field(changeset, :last_name)

    cond do
      is_nil(first) and is_nil(last) ->
        changeset

      is_binary(first) and is_binary(last) and
          String.trim(first) != "" and
          String.trim(last) != "" ->
        changeset

      true ->
        changeset
        |> add_error(:first_name, "must be present if last name is present")
        |> add_error(:last_name, "must be present if first name is present")
    end
  end

  defimpl Phoenix.HTML.Safe, for: Geo.Point do
    def to_iodata(%Geo.Point{coordinates: {lng, lat}}) do
      Plug.HTML.html_escape("#{Float.round(lat, 6)}, #{Float.round(lng, 6)}")
    end
  end
end
