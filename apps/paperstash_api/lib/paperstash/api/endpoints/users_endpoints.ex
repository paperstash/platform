defmodule PaperStash.Api.Endpoints.Users do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/v1/me" do
    {501, ""}
  end

  get "/v1/users/:id" do
    case PaperStash.Repo.get(PaperStash.User, id) do
      nil -> {404, %{error: :does_not_exist}}
      user -> {200, Blazon.to_map(PaperStash.UserSerializer, user)}
    end
  end

  get "/v1/users/:id/stars" do
    {501, ""}
  end

  get "/v1/users/:id/followers" do
    {501, ""}
  end

  get "/v1/users/:id/following" do
    {501, ""}
  end

  get "/v1/users/:id/activity" do
    {501, ""}
  end
end
