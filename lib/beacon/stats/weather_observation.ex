defmodule Beacon.Stats.WeatherObservation do
  use Beacon.Schema
  import Ecto.Changeset
  alias Beacon.Constant

  @schema_prefix "stats"

  schema "weather_observations" do
    field :public_id, Ecto.UUID, autogenerate: false, read_after_writes: true

    field :observed_at, :utc_datetime

    field :temperature, :decimal
    field :feels_like, :decimal

    field :humidity, :integer
    field :atmospheric_pressure, :integer

    field :wind_speed, :decimal
    field :precipitation, :decimal

    field :condition_main, :string
    field :condition_description, :string

    belongs_to :city, Beacon.Geo.City

    timestamps()
  end

  @required_fields [
    :public_id,
    :city_id,
    :observed_at,
    :temperature
  ]
  @optional_fields [
    :feels_like,
    :humidity,
    :atmospheric_pressure,
    :wind_speed,
    :precipitation,
    :condition_main,
    :condition_description
  ]
  def changeset(weather_observation, attrs) do
    weather_observation
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:humidity,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    )
    |> validate_number(:atmospheric_pressure, greater_than: 0)
    |> validate_number(:wind_speed, greater_than_or_equal_to: 0.0)
    |> validate_number(:precipitation, greater_than_or_equal_to: 0.0)
    |> validate_length(:condition_main, max: Constant.varchar_max_length())
    |> validate_length(:condition_description, max: Constant.varchar_max_length())
    |> foreign_key_constraint(:city_id)
    |> unique_constraint(
      [:city_id, :observed_at],
      name: :weather_observations_city_id_observed_at_idx
    )
    |> unique_constraint(:public_id, name: :weather_observations_public_id_idx)
  end
end
