defmodule Beacon.Stats.PsaIncomeExpenditure do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "stats"

  schema "psa_income_expenditures" do
    field :year, :integer

    field :avg_family_income, :decimal
    field :avg_family_expenditure, :decimal

    field :savings_ratio, :float
    field :gini_coefficient, :float

    belongs_to :region, Beacon.Geo.Region

    timestamps()
  end

  @required_fields [
    :region_id,
    :year
  ]
  @optional_fields [
    :avg_family_income,
    :avg_family_expenditure,
    :savings_ratio,
    :gini_coefficient
  ]
  def changeset(psa_income_expenditure, attrs) do
    psa_income_expenditure
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:year, greater_than_or_equal_to: Constant.psa_min_year())
    |> validate_number(:avg_family_income, greater_than_or_equal_to: 0)
    |> validate_number(:avg_family_expenditure, greater_than_or_equal_to: 0)
    |> validate_number(:gini_coefficient, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0)
    |> foreign_key_constraint(:region_id)
    |> unique_constraint(
      [:region_id, :year],
      name: :psa_income_expenditures_region_id_year_idx
    )
  end
end
