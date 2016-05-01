defmodule PaperStash.Follow do
  @moduledoc ~S"""
  """

  use PaperStash.Model

  # TODO(mtwilliams): Allow users to follow people?
  schema "follows" do
    belongs_to :follower, PaperStash.User
    belongs_to :followee, PaperStash.User
  end
end
