defmodule Beacon.OpsTest do
  use Beacon.DataCase

  alias Beacon.Ops

  describe "outages" do
    alias Beacon.Ops.Outage

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.OpsFixtures

    @invalid_attrs %{}

    test "list_outages/1 returns all scoped outages" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)
      other_outage = outage_fixture(other_scope)
      assert Ops.list_outages(scope) == [outage]
      assert Ops.list_outages(other_scope) == [other_outage]
    end

    test "get_outage!/2 returns the outage with given id" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      other_scope = user_scope_fixture()
      assert Ops.get_outage!(scope, outage.id) == outage
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(other_scope, outage.id) end
    end

    test "create_outage/2 with valid data creates a outage" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %Outage{} = outage} = Ops.create_outage(scope, valid_attrs)
      assert outage.user_id == scope.user.id
    end

    test "create_outage/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Ops.create_outage(scope, @invalid_attrs)
    end

    test "update_outage/3 with valid data updates the outage" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      update_attrs = %{}

      assert {:ok, %Outage{} = outage} = Ops.update_outage(scope, outage, update_attrs)
    end

    test "update_outage/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)

      assert_raise MatchError, fn ->
        Ops.update_outage(other_scope, outage, %{})
      end
    end

    test "update_outage/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Ops.update_outage(scope, outage, @invalid_attrs)
      assert outage == Ops.get_outage!(scope, outage.id)
    end

    test "delete_outage/2 deletes the outage" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert {:ok, %Outage{}} = Ops.delete_outage(scope, outage)
      assert_raise Ecto.NoResultsError, fn -> Ops.get_outage!(scope, outage.id) end
    end

    test "delete_outage/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert_raise MatchError, fn -> Ops.delete_outage(other_scope, outage) end
    end

    test "change_outage/2 returns a outage changeset" do
      scope = user_scope_fixture()
      outage = outage_fixture(scope)
      assert %Ecto.Changeset{} = Ops.change_outage(scope, outage)
    end
  end
end
