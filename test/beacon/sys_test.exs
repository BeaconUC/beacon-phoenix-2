defmodule Beacon.SysTest do
  use Beacon.DataCase

  alias Beacon.Sys

  describe "system_configs" do
    alias Beacon.Sys.SystemConfig

    import Beacon.SysFixtures

    @invalid_attrs %{}

    test "list_system_configs/0 returns all system_configs" do
      system_config = system_config_fixture()
      assert Sys.list_system_configs() == [system_config]
    end

    test "get_system_config!/1 returns the system_config with given id" do
      system_config = system_config_fixture()
      assert Sys.get_system_config!(system_config.id) == system_config
    end

    test "create_system_config/1 with valid data creates a system_config" do
      valid_attrs = %{}

      assert {:ok, %SystemConfig{} = system_config} = Sys.create_system_config(valid_attrs)
    end

    test "create_system_config/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sys.create_system_config(@invalid_attrs)
    end

    test "update_system_config/2 with valid data updates the system_config" do
      system_config = system_config_fixture()
      update_attrs = %{}

      assert {:ok, %SystemConfig{} = system_config} = Sys.update_system_config(system_config, update_attrs)
    end

    test "update_system_config/2 with invalid data returns error changeset" do
      system_config = system_config_fixture()
      assert {:error, %Ecto.Changeset{}} = Sys.update_system_config(system_config, @invalid_attrs)
      assert system_config == Sys.get_system_config!(system_config.id)
    end

    test "delete_system_config/1 deletes the system_config" do
      system_config = system_config_fixture()
      assert {:ok, %SystemConfig{}} = Sys.delete_system_config(system_config)
      assert_raise Ecto.NoResultsError, fn -> Sys.get_system_config!(system_config.id) end
    end

    test "change_system_config/1 returns a system_config changeset" do
      system_config = system_config_fixture()
      assert %Ecto.Changeset{} = Sys.change_system_config(system_config)
    end
  end
end
