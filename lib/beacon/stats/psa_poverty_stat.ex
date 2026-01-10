defmodule Beacon.Stats.PsaPovertyStat do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "stats"

  schema "psa_poverty_stats" do
    field :year, :integer

    field :poverty_threshold_per_capita, :decimal
    field :food_threshold_per_capita, :decimal

    field :poverty_incidence_families, :float
    field :poverty_incidence_population, :float
    field :subsistence_incidence_population, :float

    field :magnitude_poor_families, :integer
    field :magnitude_poor_population, :integer

    belongs_to :province, Beacon.Geo.Province

    timestamps()
  end

  @required_fields [
    :province_id,
    :year
  ]
  @optional_fields [
    :poverty_threshold_per_capita,
    :food_threshold_per_capita,
    :poverty_incidence_families,
    :poverty_incidence_population,
    :subsistence_incidence_population,
    :magnitude_poor_families,
    :magnitude_poor_population
  ]
  def changeset(psa_poverty_stat, attrs) do
    psa_poverty_stat
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_number(:poverty_threshold_per_capita, greater_than_or_equal_to: 0)
    |> validate_number(:food_threshold_per_capita, greater_than_or_equal_to: 0)
    |> validate_number(:poverty_incidence_families,
      greater_than_or_equal_to: 0.0,
      less_than_or_equal_to: 100.0
    )
    |> validate_number(:poverty_incidence_population,
      greater_than_or_equal_to: 0.0,
      less_than_or_equal_to: 100.0
    )
    |> validate_number(:subsistence_incidence_population,
      greater_than_or_equal_to: 0.0,
      less_than_or_equal_to: 100.0
    )
    |> validate_number(:magnitude_poor_families, greater_than_or_equal_to: 0)
    |> validate_number(:magnitude_poor_population, greater_than_or_equal_to: 0)
    |> validate_threshold_logic()
    |> foreign_key_constraint(:province_id)
    |> unique_constraint(
      [:province_id, :year],
      name: :psa_poverty_stats_province_id_year_idx
    )
  end

  defp validate_threshold_logic(changeset) do
    poverty = get_field(changeset, :poverty_threshold_per_capita)
    food = get_field(changeset, :food_threshold_per_capita)

    cond do
      is_nil(poverty) or is_nil(food) ->
        changeset

      Decimal.compare(poverty, food) in [:gt, :eq] ->
        changeset

      true ->
        add_error(
          changeset,
          :poverty_threshold_per_capita,
          "must be greater than or equal to food_threshold_per_capita"
        )
    end
  end
end
