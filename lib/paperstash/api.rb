module PaperStash
  class API < Grind::Application
    # We expose a status-checking endpoint at `/v1/status` that is cascaded to
    # after everything else to make sure our application is healthy.
    mount StatusEndpoint
  end
end
