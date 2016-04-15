use Mix.Config

config :logger, :console,
  level: :debug

config :paperstash, PaperStash.Repo,
  hostname: String.rstrip(elem(System.cmd("docker-machine", ["ip", "default"]), 0)),
  port: 32778,
  database: "e8uuvoq6wybl3tes",
  username: "paperstash",
  password: "gJ4c5x0rPJUzQUSHtszweLpW2PeER0Kv",
  ssl: false,
  connect_timeout: 5000,
  timeout: 5000
