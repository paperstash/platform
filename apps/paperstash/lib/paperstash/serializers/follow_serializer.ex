defmodule PaperStash.FollowSerializer do
  @moduledoc ~S"""
  """

  use PaperStash.Serializer

  hook :before do
    PaperStash.Repository.preload(model, ~W{follower followee}a)
  end

  embed :follower, PaperStash.UserSerializer
  embed :followee, PaperStash.UserSerializer
end
