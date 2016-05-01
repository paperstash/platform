defmodule PaperStash.App.Endpoints.OAuth2 do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/oauth2/authorize" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/oauth2/authorize" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/oauth2/complete" do
    {501, %{error: :not_implemented_yet}}
  end
end
