defmodule PaperStash.Api.Router do
  @moduledoc ~S"""
  """

  use Trot.Router

  # We expose a status endpoint only after everything else so that if the
  # aforementioned fuck up and break the pipeline, our status endpoint will
  # fail (and we will know something is seriously wrong.)
  import_routes PaperStash.Api.StatusEndpoints

  # TODO(mtwilliams): Replace with our own handler.
  import_routes Trot.NotFound
end
