defmodule Beacon.Stats.PsaEconomicPerformance do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "stats"

  schema "psa_economic_performances" do
    field :year, :integer

    field :grdp_value, :decimal
    field :grdp_growth_rate, :float

    field :gva_agriculture, :decimal
    field :gva_industry, :decimal
    field :gva_services, :decimal

    belongs_to :region, Beacon.Geo.Region

    timestamps()
  end

  @required_fields [
    :region_id,
    :year
  ]
  @optional_fields [
    :grdp_value,
    :grdp_growth_rate,
    :gva_agriculture,
    :gva_industry,
    :gva_services
  ]
  def changeset(psa_economic_performance, attrs) do
    psa_economic_performance
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_number(:grdp_value, greater_than_or_equal_to: 0)
    |> validate_number(:gva_agriculture, greater_than_or_equal_to: 0)
    |> validate_number(:gva_industry, greater_than_or_equal_to: 0)
    |> validate_number(:gva_services, greater_than_or_equal_to: 0)
    |> foreign_key_constraint(:region_id)
    |> unique_constraint(
      [:region_id, :year],
      name: :psa_economic_performances_region_id_year_idx
    )
  end
end
