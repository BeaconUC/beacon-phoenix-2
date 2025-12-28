defmodule Beacon.Sys.SystemConfig do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "sys"

  schema "system_configs" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :key, :string
    field :value, :string
    field :description, :string

    belongs_to :updated_by, Beacon.Iam.Profile

    timestamps()
  end

  @required_fields [
    :public_id,
    :key,
    :value
  ]
  @optional_fields [
    :description,
    :updated_by_id
  ]
  def changeset(system_config, attrs) do
    system_config
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:key, min: 1)
    |> validate_length(:value, min: 1)
    |> validate_length(:description, max: Constant.text_max_length())
    |> foreign_key_constraint(:updated_by_id)
    |> unique_constraint(:key, name: :system_configs_key_idx)
    |> unique_constraint(:public_id, name: :system_configs_public_id_idx)
  end
end
