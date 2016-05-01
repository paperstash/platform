defmodule PaperStash.Api.Endpoints.Users do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/v1/me" do
    {501, ""}
  end

  get "/v1/users/:id" do
    case PaperStash.Repo.get(PaperStash.User, id) do
      nil ->
        {404, %{error: :does_not_exist}}
      user ->
        {200, Blazon.to_map(PaperStash.UserSerializer, user)}
    end
  end

  get "/v1/users/:id/stars" do
    {501, ""}
  end

  get "/v1/users/:id/followers" do
    case PaperStash.Repo.get(PaperStash.User, id) do
      nil ->
        {404, %{error: :does_not_exist}}
      user ->
        # TODO(mtwilliams): Pagination.
        user = PaperStash.Repo.preload(user, ~w(followers)a)
        # REFACTOR(mtwilliams): Collections into Blazon.
        # REFACTOR(mtwilliams): Follower-specific serialization into `PaperStash.FollowerSerializer`.
        followers = Enum.map(user.followers, &(Blazon.to_map(PaperStash.UserSerializer, &1, only: ~w(id portrait name nickname)a)))
        {200, followers}
    end
  end

  get "/v1/users/:id/following" do
    case PaperStash.Repo.get(PaperStash.User, id) do
      nil ->
        {404, %{error: :does_not_exist}}
      user ->
        # TODO(mtwilliams): Pagination.
        user = PaperStash.Repo.preload(user, ~w(followees)a)
        # REFACTOR(mtwilliams): Collections into Blazon.
        # REFACTOR(mtwilliams): Follower-specific serialization into `PaperStash.FollowerSerializer`.
        followees = Enum.map(user.followees, &(Blazon.to_map(PaperStash.UserSerializer, &1, only: ~w(id portrait name nickname)a)))
        {200, followees}
    end
  end

  get "/v1/users/:id/activity" do
    {501, ""}
  end
end
