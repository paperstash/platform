use Mix.Config

config :logger, :console,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: []

config :paperstash, PaperStash.Repo,
  adapter: Ecto.Adapters.Postgres,
  name: PaperStash.Repo,
  encoding: "UTF8",
  log_level: :debug

import_config "#{Mix.env}.exs"
