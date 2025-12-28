defmodule Beacon.Iam.ApiKey do
  use Beacon.Schema
  import Ecto.Changeset

  schema "api_keys" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :name, :string
    field :api_key, :string
    field :secret_key, :string
    field :service_name, :string

    field :is_active, :boolean
    field :rate_limit_per_minute, :integer
    field :expires_at, :utc_datetime

    belongs_to :created_by, Beacon.Iam.Profile
    belongs_to :updated_by, Beacon.Iam.Profile

    timestamps()
  end

  @required_fields [
    :public_id,
    :name,
    :api_key,
    :is_active,
    :rate_limit_per_minute,
    :created_by_id,
    :updated_by_id
  ]
  @optional_fields [
    :secret_key,
    :service_name,
    :expires_at
  ]
  def changeset(api_key, attrs) do
    api_key
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:rate_limit_per_minute, greater_than: 0)
    |> validate_expires_at()
    |> foreign_key_constraint(:created_by_id)
    |> foreign_key_constraint(:updated_by_id)
    |> unique_constraint(:api_key, name: :api_keys_api_key_idx)
    |> unique_constraint(:name, name: :api_keys_name_idx)
    |> unique_constraint(:public_id, name: :api_keys_public_id_idx)
  end

  defp validate_expires_at(changeset) do
    case get_field(changeset, :expires_at) do
      nil ->
        changeset

      expires_at ->
        if DateTime.compare(expires_at, DateTime.utc_now()) == :gt do
          changeset
        else
          add_error(changeset, :expires_at, "must be in the future")
        end
    end
  end
end
