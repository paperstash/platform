use Mix.Config

config :paperstash_web, PaperStash.Web.Router,
  port: 80

config :paperstash_web, PaperStash.Web.Routes,
  # Don't generate pretty responses.
  pretty: false
