defmodule Beacon.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @primary_key {:id, :id, autogenerate: true}
      @foreign_key_type :id

      @timestamps_opts inserted_at: :created_at, type: :utc_datetime
    end
  end
end
