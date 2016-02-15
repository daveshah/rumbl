defmodule Rumbl.Repo do
#  use Ecto.Repo, otp_app: :rumbl
  @moduledoc """
  In memory repository
  """

  def all(Rumbl.User) do
    [%Rumbl.User{id: "1", name: "Dave", username: "daveshah", password: "high-fives"},
     %Rumbl.User{id: "2", name: "Brave", username: "braveshah", password: "high-dives"},
     %Rumbl.User{id: "3", name: "Rave", username: "Raveshah", password: "high-lives"}]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map -> 
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end) 
    end
  end

end
