defmodule Beacon.Constant do
  @moduledoc false

  @varchar_max_length 255
  @text_max_length 10_000
  @psa_min_year 2020

  def varchar_max_length, do: @varchar_max_length
  def text_max_length, do: @text_max_length
  def psa_min_year, do: @psa_min_year
end
