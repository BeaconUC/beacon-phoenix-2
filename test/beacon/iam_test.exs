defmodule Beacon.IamTest do
  use Beacon.DataCase

  alias Beacon.Iam

  describe "profiles" do
    alias Beacon.Iam.Profile

    import Beacon.IamFixtures

    @invalid_attrs %{}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Iam.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Iam.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{}

      assert {:ok, %Profile{} = profile} = Iam.create_profile(valid_attrs)
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      update_attrs = %{}

      assert {:ok, %Profile{} = profile} = Iam.update_profile(profile, update_attrs)
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_profile(profile, @invalid_attrs)
      assert profile == Iam.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Iam.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Iam.change_profile(profile)
    end
  end

  describe "profile_settings" do
    alias Beacon.Iam.ProfileSetting

    import Beacon.IamFixtures

    @invalid_attrs %{}

    test "list_profile_settings/0 returns all profile_settings" do
      profile_setting = profile_setting_fixture()
      assert Iam.list_profile_settings() == [profile_setting]
    end

    test "get_profile_setting!/1 returns the profile_setting with given id" do
      profile_setting = profile_setting_fixture()
      assert Iam.get_profile_setting!(profile_setting.id) == profile_setting
    end

    test "create_profile_setting/1 with valid data creates a profile_setting" do
      valid_attrs = %{}

      assert {:ok, %ProfileSetting{} = profile_setting} = Iam.create_profile_setting(valid_attrs)
    end

    test "create_profile_setting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_profile_setting(@invalid_attrs)
    end

    test "update_profile_setting/2 with valid data updates the profile_setting" do
      profile_setting = profile_setting_fixture()
      update_attrs = %{}

      assert {:ok, %ProfileSetting{} = profile_setting} = Iam.update_profile_setting(profile_setting, update_attrs)
    end

    test "update_profile_setting/2 with invalid data returns error changeset" do
      profile_setting = profile_setting_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_profile_setting(profile_setting, @invalid_attrs)
      assert profile_setting == Iam.get_profile_setting!(profile_setting.id)
    end

    test "delete_profile_setting/1 deletes the profile_setting" do
      profile_setting = profile_setting_fixture()
      assert {:ok, %ProfileSetting{}} = Iam.delete_profile_setting(profile_setting)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_profile_setting!(profile_setting.id) end
    end

    test "change_profile_setting/1 returns a profile_setting changeset" do
      profile_setting = profile_setting_fixture()
      assert %Ecto.Changeset{} = Iam.change_profile_setting(profile_setting)
    end
  end

  describe "api_keys" do
    alias Beacon.Iam.ApiKey

    import Beacon.IamFixtures

    @invalid_attrs %{}

    test "list_api_keys/0 returns all api_keys" do
      api_key = api_key_fixture()
      assert Iam.list_api_keys() == [api_key]
    end

    test "get_api_key!/1 returns the api_key with given id" do
      api_key = api_key_fixture()
      assert Iam.get_api_key!(api_key.id) == api_key
    end

    test "create_api_key/1 with valid data creates a api_key" do
      valid_attrs = %{}

      assert {:ok, %ApiKey{} = api_key} = Iam.create_api_key(valid_attrs)
    end

    test "create_api_key/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_api_key(@invalid_attrs)
    end

    test "update_api_key/2 with valid data updates the api_key" do
      api_key = api_key_fixture()
      update_attrs = %{}

      assert {:ok, %ApiKey{} = api_key} = Iam.update_api_key(api_key, update_attrs)
    end

    test "update_api_key/2 with invalid data returns error changeset" do
      api_key = api_key_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_api_key(api_key, @invalid_attrs)
      assert api_key == Iam.get_api_key!(api_key.id)
    end

    test "delete_api_key/1 deletes the api_key" do
      api_key = api_key_fixture()
      assert {:ok, %ApiKey{}} = Iam.delete_api_key(api_key)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_api_key!(api_key.id) end
    end

    test "change_api_key/1 returns a api_key changeset" do
      api_key = api_key_fixture()
      assert %Ecto.Changeset{} = Iam.change_api_key(api_key)
    end
  end
end
