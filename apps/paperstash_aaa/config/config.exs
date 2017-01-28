use Mix.Config

config :paperstash_aaa, :sessions,
  # Sessions last up to a week of inactivity.
  ttl: 7 * 24 * 60 * 60

config :quantum, cron: [
  # Prune expired sessions every 15 minutes.
  "*/15 * * * *": &PaperStash.SessionStore.vacuum/0
]
