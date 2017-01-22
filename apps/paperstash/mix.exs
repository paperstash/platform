defmodule PaperStash.Mixfile do
  use Mix.Project

  def project do [
    app: :paperstash,
    version: version(),
    elixir: "~> 1.4",
    build_path: "../../_build",
    deps_path: "../../_deps",
    lockfile: "../../mix.lock",
    build_embedded: Mix.env() == :prod,
    start_permanent: Mix.env() == :prod,
    deps: deps(),
    aliases: aliases()
  ] end

  def application do [
    mod: {PaperStash, []},
    # applications: ~W{logger timex timex_ecto comeonin postgrex ecto}a,
    env: []
  ] end

  # TODO(mtwilliams): Bake version?
  defp version do
    case System.cmd("git", ["describe", "--tags"], stderr_to_stdout: true) do
      {tag, 0} ->
        String.strip(tag)
      _ ->
        # HACK(mtwilliams): Default to `0.0.0`.
        "0.0.0"
    end
  end

  defp deps do [
    # Basics
    {:decimal, "~> 1.0"},
    {:uuid, "~> 1.0"},
    {:timex, ">= 0.0.0"},
    {:timex_ecto, ">= 0.0.0"},
    {:blazon, ">= 0.0.0"},
    {:poison, "~> 3.0"},
    {:httpoison, ">= 0.0.0"},

    # Encryption
    {:comeonin, "~> 2.0"},
    {:comeonin_ecto_password, ">= 0.0.0"},

    # Database
    {:ecto, "~> 2.0"},
    {:ecto_enum, github: "mtwilliams/ecto_enum", branch: "simplifications"},
    {:scrivener_ecto, ">= 0.0.0"},
    {:postgrex, ">= 0.0.0"}
  ] end

  defp aliases do [
  ] end
end
