defmodule PaperStash.Web.Endpoints.OAuth2 do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  get "/oauth2/authorize" do
    raise NotImplementedError
  end

  post "/oauth2/authorize" do
    raise NotImplementedError
  end

  post "/oauth2/complete" do
    raise NotImplementedError
  end
end
