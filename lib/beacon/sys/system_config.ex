defmodule Beacon.Sys.SystemConfig do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "sys"

  schema "system_configs" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(system_config, attrs) do
    system_config
    |> cast(attrs, [])
    |> validate_required([])
  end
end
