use Mix.Config

config :logger, :console,
  metadata: [:request]

config :paperstash_web,
  ecto_repos: []

import_config "#{Mix.env}.exs"
