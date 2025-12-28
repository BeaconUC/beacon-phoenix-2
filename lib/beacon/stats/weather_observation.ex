defmodule Beacon.Stats.WeatherObservation do
  use Beacon.Schema
  import Ecto.Changeset

  @schema_prefix "stats"

  schema "weather_observations" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(weather_observation, attrs) do
    weather_observation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
