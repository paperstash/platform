defmodule PaperStash.Api.UsersEndpoints do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/v1/me" do
    {501, ""}
  end

  get "/v1/users/:id" do
    {501, ""}
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
