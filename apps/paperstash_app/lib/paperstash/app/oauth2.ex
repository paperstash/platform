defmodule PaperStash.App.OAuth2 do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/oauth2/authorize" do
    {501, %{error: :unimplemented}}
  end

  post "/oauth2/authorize" do
    {501, %{error: :unimplemented}}
  end

  post "/oauth2/complete" do
    {501, %{error: :unimplemented}}
  end
end
