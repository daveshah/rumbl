defmodule Rumbl.UserRepoTest do
  use Rumbl.ModelCase
  alias Rumbl.User

  @valid_attrs %{name: "Test Userston", username: "TUserton",
                 password: "foobar", password_confirmation: "foobar"}

  test "converts unique constraint on username to error" do
    insert_user(username: "nacho")

    attrs = Map.put(@valid_attrs, :username, "nacho")

    changest = User.changeset(%User{}, attrs)

    assert {:error, changeset} = Repo.insert(changest)
    assert {:username, "has already been taken"} in changeset.errors
  end

end

