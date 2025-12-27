defmodule Beacon.OpsTest do
  use Beacon.DataCase

  alias Beacon.Ops

  describe "outages" do
    alias Beacon.Ops.Outage

    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outages/0 returns all outages" do
      outage = outage_fixture()
      assert Ops.list_outages() == [outage]
    end

    test "get_outage!/1 returns the outage with given id" do
      outage = outage_fixture()
      assert Ops.get_outage!(outage.id) == outage
    end

    test "create_outage/1 with valid data creates a outage" do
      valid_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.create_outage(valid_attrs)
    end

    test "create_outage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage(@invalid_attrs)
    end

    test "update_outage/2 with valid data updates the outage" do
      outage = outage_fixture()
      update_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.update_outage(outage, update_attrs)
    end

    test "update_outage/2 with invalid data returns error changeset" do
      outage = outage_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage(outage, @invalid_attrs)
      assert outage == Ops.get_outage!(outage.id)
    end

    test "delete_outage/1 deletes the outage" do
      outage = outage_fixture()
      assert {:ok, %Outage{}} = Ops.delete_outage(outage)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(outage.id) end
    end

    test "change_outage/1 returns a outage changeset" do
      outage = outage_fixture()
      assert %Ecto.Changeset{} = Ops.change_outage(outage)
    end
  end
end
