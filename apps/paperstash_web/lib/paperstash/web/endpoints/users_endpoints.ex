defmodule PaperStash.Web.Endpoints.Users do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  alias PaperStash.{User, UserSerializer,
                    Follow, FollowSerializer,
                    PageSerializer}

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

  get "/v1/users/:id/follows" do
    user = User.get!(id)
    page = User.follows(user) |> R.paginate!(conn.params)
    json PageSerializer.map(page, serializer: &FollowSerializer.follow/1)
  end

  get "/v1/users/:id/following" do
    user = R.get!(User, id)
    page = User.following(user) |> R.paginate!(conn.params)
    json PageSerializer.map(page, serializer: &FollowSerializer.following/1)
  end

  post "/v1/users/:id/follow" do
    raise NotImplementedError
  end

  post "/v1/users/:id/unfollow" do
    raise NotImplementedError
  end

  get "/v1/users/:id/activity" do
    raise NotImplementedError
  end

  fallthrough
end
