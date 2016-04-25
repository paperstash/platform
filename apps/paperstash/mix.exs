defmodule PaperStash.Mixfile do
  use Mix.Project

  def project do
    [app: :paperstash,
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
     applications: ~w{logger timex ecto postgrex}a,
     mod: {PaperStash, []}]
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
    {:decimal, "~> 1.1.0"},
    {:poison, "~> 1.0"},
    {:timex, ">= 0.0.0"},
    {:timex_ecto, ">= 0.0.0"},
    {:uuid, "~> 1.1"},

    # Database
    {:ecto, "~> 1.0"},
    {:ecto_enum, "~> 0.3.0"},
    {:postgrex, ">= 0.0.0"},
  ] end

  defp aliases do
    []
  end
end
