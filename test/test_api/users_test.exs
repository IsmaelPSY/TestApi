defmodule TestApi.UsersTest do
  use TestApi.DataCase

  alias TestApi.Users

  describe "users" do
    alias TestApi.Users.User

    import TestApi.UsersFixtures
    import TestApi.AccountsFixtures

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        full_name: "some fullname",
        gender: "some gender",
        biography: "some biography"
      }

      account = account_fixture()

      assert {:ok, %User{} = user} = Users.create_user(account, valid_attrs)
      assert user.full_name == "some fullname"
      assert user.gender == "some gender"
      assert user.biography == "some biography"
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        full_name: "some updated fullname",
        gender: "some updated gender",
        biography: "some updated biography"
      }

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.full_name == "some updated fullname"
      assert user.gender == "some updated gender"
      assert user.biography == "some updated biography"
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
