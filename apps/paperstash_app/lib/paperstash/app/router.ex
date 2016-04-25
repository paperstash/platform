defmodule PaperStash.App.Router do
  @moduledoc ~S"""
  """

  use Trot.Router

  plug Plug.Static,
    at: "/",
    from: {:paperstash_app, "priv/static"},
    only: ~w(assets robots.txt)

  import_routes PaperStash.App.Spa

  import_routes PaperStash.App.Endpoints.Users
  import_routes PaperStash.App.Endpoints.Sessions
  import_routes PaperStash.App.Endpoints.OAuth2

  # TODO(mtwilliams): Replace with our own handler.
  import_routes Trot.NotFound
end
