defmodule Beacon.IamTest do
  use Beacon.DataCase

  alias Beacon.Iam

  describe "profiles--no-migration" do
    alias Beacon.Iam.Profile

    import Beacon.AccountsFixtures, only: [user_scope_fixture: 0]
    import Beacon.IamFixtures

    @invalid_attrs %{}

    test "list_profiles--no-migration/1 returns all scoped profiles--no-migration" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      profile = profile_fixture(scope)
      other_profile = profile_fixture(other_scope)
      assert Iam.list_profiles() -- (no - migration(scope)) == [profile]
      assert Iam.list_profiles() -- (no - migration(other_scope)) == [other_profile]
    end

    test "get_profile!/2 returns the profile with given id" do
      scope = user_scope_fixture()
      profile = profile_fixture(scope)
      other_scope = user_scope_fixture()
      assert Iam.get_profile!(scope, profile.id) == profile
      assert_raise Ecto.NoResultsError, fn -> Iam.get_profile!(other_scope, profile.id) end
    end

    test "create_profile/2 with valid data creates a profile" do
      valid_attrs = %{}
      scope = user_scope_fixture()

      assert {:ok, %Profile{} = profile} = Iam.create_profile(scope, valid_attrs)
      assert profile.user_id == scope.user.id
    end

    test "create_profile/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.create_profile(scope, @invalid_attrs)
    end

    test "update_profile/3 with valid data updates the profile" do
      scope = user_scope_fixture()
      profile = profile_fixture(scope)
      update_attrs = %{}

      assert {:ok, %Profile{} = profile} = Iam.update_profile(scope, profile, update_attrs)
    end

    test "update_profile/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      profile = profile_fixture(scope)

      assert_raise MatchError, fn ->
        Iam.update_profile(other_scope, profile, %{})
      end
    end

    test "update_profile/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      profile = profile_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Iam.update_profile(scope, profile, @invalid_attrs)
      assert profile == Iam.get_profile!(scope, profile.id)
    end

    test "delete_profile/2 deletes the profile" do
      scope = user_scope_fixture()
      profile = profile_fixture(scope)
      assert {:ok, %Profile{}} = Iam.delete_profile(scope, profile)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_profile!(scope, profile.id) end
    end

    test "delete_profile/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      profile = profile_fixture(scope)
      assert_raise MatchError, fn -> Iam.delete_profile(other_scope, profile) end
    end

    test "change_profile/2 returns a profile changeset" do
      scope = user_scope_fixture()
      profile = profile_fixture(scope)
      assert %Ecto.Changeset{} = Iam.change_profile(scope, profile)
    end
  end
end
