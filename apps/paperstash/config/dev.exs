use Mix.Config

config :paperstash, PaperStash.Repository,
  loggers: [{Ecto.LogEntry, :log, [:debug]}],
  pool_size: 1
