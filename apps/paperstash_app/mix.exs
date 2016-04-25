defmodule PaperStash.App.Mixfile do
  use Mix.Project

  def project do
    [app: :paperstash_app,
     version: version,
     elixir: "~> 1.0",
     build_path: "../../_build",
     deps_path: "../../_deps",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     aliases: aliases]
  end

  def application do
    [env: [],
     applications: ~w{paperstash cowboy plug}a,
     mod: {PaperStash.App, []}]
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
    {:paperstash, in_umbrella: true},

    # Web
    {:cowboy, "~> 1.0.0"},
    {:plug, "~> 1.0"},
    {:trot, github: "hexedpackets/trot"}
  ] end

  defp aliases do
    []
  end
end
