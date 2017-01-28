defmodule PaperStash.Web.Endpoints.Users do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  alias PaperStash.{User, UserSerializer, FollowSerializer}

  get "/v1/me" do
    raise NotImplementedError
  end

  get "/v1/users" do
    json paginate(User)
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
    json paginate(User.follows(user), serializer: &FollowSerializer.follow/1)
  end

  get "/v1/users/:id/following" do
    user = User.get!(id)
    json paginate(User.following(user), serializer: &FollowSerializer.following/1)
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
end
