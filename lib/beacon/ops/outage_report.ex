defmodule Beacon.Ops.OutageReport do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.{Constant, Enum}

  @schema_prefix "ops"

  schema "outage_reports" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :location, Geo.PostGIS.Geometry
    field :description, :string
    field :image_url, :string

    field :status, Ecto.Enum, values: Enum.report_status_values()

    belongs_to :reported_by_profile, Beacon.Iam.Profile, foreign_key: :reported_by
    belongs_to :linked_outage, Beacon.Ops.Outage
    belongs_to :barangay, Beacon.Geo.Barangay

    timestamps()
  end

  @required_fields []
  @optional_fields [
    :status,
    :description,
    :image_url,
    :reported_by,
    :linked_outage_id,
    :barangay_id
  ]
  def changeset(outage_report, attrs) do
    outage_report
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> maybe_put_location(attrs)
    |> validate_required(@required_fields)
    |> validate_length(:description, max: Constant.text_max_length())
    |> foreign_key_constraint(:reported_by_id)
    |> foreign_key_constraint(:linked_outage_id)
    |> foreign_key_constraint(:barangay_id)
    |> unique_constraint(:public_id, name: :outage_reports_public_id_idx)
  end

  defp maybe_put_location(changeset, %{"location" => %Geo.Point{} = point}) do
    put_change(changeset, :location, point)
  end

  defp maybe_put_location(changeset, _), do: changeset
end
