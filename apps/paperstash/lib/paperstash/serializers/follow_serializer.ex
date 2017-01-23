defmodule PaperStash.FollowSerializer do
  @moduledoc ~S"""
  """

  use PaperStash.Serializer

  hook :before do
    PaperStash.Repository.preload(model, ~W{follower followee}a)
  end

  embed :follower, PaperStash.UserSerializer
  embed :followee, PaperStash.UserSerializer

  def follow(follow) do
    Blazon.map(__MODULE__, follow, except: ~W{follower}a)
  end

  def following(follow) do
    Blazon.map(__MODULE__, follow, except: ~W{followee}a)
  end
end
