defmodule Beacon.Enum do
  @moduledoc false

  @assignment_status [:assigned, :en_route, :on_site, :paused, :completed, :cancelled]
  @outage_type [:unscheduled, :scheduled, :emergency]
  @outage_status [:unverified, :verified, :being_resolved, :resolved]
  @report_status [:unprocessed, :processed_as_part_of_outage, :processed_as_isolated, :archived]
  @roles [:user, :crew, :admin]
  @themes [:light, :dark, :system]

  @type assignment_status :: unquote(Enum.reduce(@assignment_status, &{:|, [], [&1, &2]}))
  @type outage_type :: unquote(Enum.reduce(@outage_type, &{:|, [], [&1, &2]}))
  @type outage_status :: unquote(Enum.reduce(@outage_status, &{:|, [], [&1, &2]}))
  @type report_status :: unquote(Enum.reduce(@report_status, &{:|, [], [&1, &2]}))
  @type roles :: unquote(Enum.reduce(@roles, &{:|, [], [&1, &2]}))
  @type themes :: unquote(Enum.reduce(@themes, &{:|, [], [&1, &2]}))

  def assignment_status_values, do: @assignment_status
  def outage_type_values, do: @outage_type
  def outage_status_values, do: @outage_status
  def report_status_values, do: @report_status
  def roles_values, do: @roles
  def themes_values, do: @themes
end
