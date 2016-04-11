module PaperStash
  class App < Grind::Application
    # We serve our single-page application (a little bit of HTML) via a simple
    # controller and view. We could deploy a static index.html via our a CDN,
    # but this isn't as much of an issue because it's small and will get
    # cached anyways.
    mount SpaController

    # We don't expose account creation through our API.
    mount UsersController

    # We OAuth2 against ourselves for a few reasons:
    #
    #  1. It maintains the statelessness of our API by removing the concept of
    #     sessions (and simplifies code by layering other authentication on top
    #     of tokens.)
    #
    #  2. Eases the creation and maintainence burden of maintaining various
    #     offical clients. (We have a single-page web app and will eventually
    #     have two mobile apps.)
    #
    #  3. Future proofs our "infrastructure" for new tangential offerings.
    #
    mount SessionsController
    mount AuthorizationsController

    # We serve our assets (and other incidental static files) via a simple Rack
    # application. We should serve them from a CDN in production. They'll be
    # cached by CloudFlare, but still.
    mount Statics.server

    # We expose a status-checking endpoint at `/status` that is cascaded to
    # after everything else to make sure our application is healthy.
    mount Status
  end
end
