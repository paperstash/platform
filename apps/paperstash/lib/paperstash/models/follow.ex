defmodule PaperStash.Follow do
  @moduledoc ~S"""
  """

  use PaperStash.Model

  # TODO(mtwilliams): Allow users to follow people?
  schema "follows" do
    belongs_to :follower, PaperStash.User
    belongs_to :followee, PaperStash.User
  end

  def all do
    from follow in PaperStash.Follow,
      join: follower in assoc(follow, :follower),
       join: p0 in assoc(follower, :personage),
      join: followee in assoc(follow, :followee),
       join: p1 in assoc(followee, :personage),
      preload: [follower: {follower, personage: p0},
                followee: {followee, personage: p1}],
      select: follow
  end
end
