defmodule PaperStash.App.Router do
  @moduledoc ~S"""
  """

  use Trot.Router

  plug Plug.Static,
    at: "/",
    from: {:paperstash_app, "priv/static"},
    only: ~w(assets robots.txt)

  import_routes PaperStash.App.Spa

  # TODO(mtwilliams): Replace with our own handler.
  import_routes Trot.NotFound
end
