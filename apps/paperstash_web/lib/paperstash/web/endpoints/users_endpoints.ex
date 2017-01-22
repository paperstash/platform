defmodule PaperStash.Web.Endpoints.Users do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  alias PaperStash.Repository, as: R

  alias PaperStash.Web.{NotImplementedError}

  get "/v1/me" do
    raise NotImplementedError
  end

  get "/v1/users/:id" do
    user = User.get!(id)
    json Blazon.map(UserSerializer, user)
  end

  get "/v1/users/:id/stars" do
    raise NotImplementedError
  end

  # TODO(mtwilliams): Pagination.

  # REFACTOR(mtwilliams): Move follower and followee specific serialization
  # into seperate serializers?

  get "/v1/users/:id/followers" do
    user = R.get!(User, id)
        |> R.preload(~W{followers}a)

    serialize = fn (follower) ->
      Blazon.map(UserSerializer, follower, only: ~W{id portrait name nickname}a)
    end

    user.followers |> Enum.map(serialize)
  end

  get "/v1/users/:id/following" do
    user = R.get!(User, id)
        |> R.preload(~W{followees}a)

    serialize = fn (followee) ->
      Blazon.map(UserSerializer, followee, only: ~W{id portrait name nickname}a)
    end

    user.followees |> Enum.map(serialize)
  end

  get "/v1/users/:id/activity" do
    raise NotImplementedError
  end

  fallthrough
end
