defmodule Beacon.Stats.PsaPopulationStat do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "stats"

  schema "psa_population_stats" do
    field :year, :integer

    field :total_population, :integer
    field :population_density, :float
    field :sex_ratio, :float

    belongs_to :province, Beacon.Geo.Province

    timestamps()
  end

  @required_fields [
    :province_id,
    :year,
    :total_population
  ]
  @optional_fields [
    :population_density,
    :sex_ratio
  ]
  def changeset(psa_population_stat, attrs) do
    psa_population_stat
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_number(:total_population, greater_than_or_equal_to: 0)
    |> validate_number(:population_density, greater_than_or_equal_to: 0.0)
    |> validate_number(:sex_ratio, greater_than_or_equal_to: 0.0)
    |> foreign_key_constraint(:province_id)
    |> unique_constraint(
      [:province_id, :year],
      name: :psa_population_stats_province_id_year_idx
    )
  end
end
