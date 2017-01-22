use Mix.Config

config :paperstash,
  ecto_repos: [PaperStash.Repository]

config :paperstash, PaperStash.Repository,
  loggers: [{Ecto.LogEntry, :log, [:info]}],
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  encoding: "UTF8",
  ssl: false,
  connect_timeout: 5_000,
  pool_timeout: 5_000,
  timeout: 30_000,
  pool_size: 1,
  priv: "priv/repo"

config :comeonin, Ecto.Password, Comeonin.Bcrypt
config :comeonin, :bcrypt_log_rounds, 14

import_config "#{Mix.env}.exs"
