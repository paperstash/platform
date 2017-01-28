defmodule PaperStash.Web.Mixfile do
  use Mix.Project

  def project do
    [app: :paperstash_web,
     version: version(),
     elixir: "~> 1.0",
     build_path: "../../_build",
     deps_path: "../../_deps",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env() == :prod,
     start_permanent: Mix.env() == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  def application do
    [env: [],
     # applications: ~w{logger paperstash cowboy plug}a,
     mod: {PaperStash.Web, []}]
  end

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
    # Umbrella
    {:paperstash, in_umbrella: true},

    # Web
    {:cowboy, "~> 1.0"},
    {:plug, "~> 1.0"},
    {:corsica, ">= 0.0.0"},
  ] end

  defp aliases do
    []
  end
end
