defmodule Rumbl.UserTest do
  use Rumbl.ModelCase, async: true
  alias Rumbl.User

  @valid_attrs %{name: "A user",
                 username: "testuser",
                 password: "secret",
                 password_confirmation: "secret"
               }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)

    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))

    assert {:username, {"should be at most %{count} character(s)", [count: 20]}} in 
           errors_on(%User{}, attrs)
  end

  test "registration_changest password must be at least 6 characters long" do
    attrs = Map.put(@valid_attrs, :password, "12345") 
            |> Map.put(:password_confirmation, "12345")

    changeset = User.registration_changeset(%User{}, attrs)

    assert [password_confirmation: {"should be at least %{count} character(s)", [count: 6]},
           password: {"should be at least %{count} character(s)", [count: 6]}] == changeset.errors
  end

  test "registration_changest with valid attributes hashes password" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    %{password: password, password_hash: password_hash} = changeset.changes

    assert changeset.valid?
    assert password_hash
    assert Comeonin.Bcrypt.checkpw(password, password_hash)
  end

end
