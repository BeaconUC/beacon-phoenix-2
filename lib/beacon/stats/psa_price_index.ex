defmodule Beacon.Stats.PsaPriceIndex do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "stats"

  schema "psa_price_indices" do
    field :year, :integer
    field :month, :integer

    field :cpi_all_items, :float
    field :inflation_rate, :float
    field :purchasing_power_of_peso, :float

    belongs_to :region, Beacon.Geo.Region

    timestamps()
  end

  @required_fields [
    :region_id,
    :year
  ]
  @optional_fields [
    :month,
    :cpi_all_items,
    :inflation_rate,
    :purchasing_power_of_peso
  ]
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:year, greater_than_or_equal_to: 2020)
    |> validate_inclusion(:month, 1..12)
    |> validate_number(:cpi_all_items, greater_than_or_equal_to: 0.0)
    |> validate_number(:purchasing_power_of_peso, greater_than_or_equal_to: 0.0)
    |> foreign_key_constraint(:region_id)
    |> unique_constraint(
      [:region_id, :year, :month],
      name: :psa_price_indices_region_id_year_month_idx
    )
  end
end
