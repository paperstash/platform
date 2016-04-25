use Mix.Config

config :logger, :console,
  level: :debug

database_from_docker = fn ->
  {host, 0} = System.cmd("docker-machine", ["ip", "default"])
  host = String.rstrip(host)

  {port, 0} = System.cmd("/bin/bash", ["-c", "docker inspect paperstash_db_1 | jq '.[0].NetworkSettings.Ports.\"5432/tcp\"[0].HostPort|tonumber'"])
  {port, ""} = port = Integer.parse(String.rstrip(port))

  %{host: host, port: port}
end

database =
  cond do
    System.get_env("TRAVIS") ->
      %{host: "localhost", port: 5432}
    System.get_env("DOCKER") ->
      %{host: "postgres", port: 5432}
    true ->
      database_from_docker.()
  end

config :paperstash, PaperStash.Repo,
  hostname: database.host,
  port: database.port,
  database: "e8uuvoq6wybl3tes",
  username: "paperstash",
  password: "gJ4c5x0rPJUzQUSHtszweLpW2PeER0Kv",
  ssl: false,
  connect_timeout: 5000,
  timeout: 5000

config :swoosh,
  serve_mailbox: true,
  preview_port: 7777
