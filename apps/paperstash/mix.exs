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
     applications: ~w{logger timex comeonin ecto postgrex swoosh}a,
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
    # HACK(mtwilliams): We need to depend on Plug so Swoosh's mailbox preview
    # functionality is compiled in. (Only compiles in if Plug is available.)
    {:plug, ">= 0.0.0"},

    # Basics
    {:decimal, "~> 1.1.0"},
    {:uuid, "~> 1.1"},
    {:timex, ">= 0.0.0"},
    {:timex_ecto, ">= 0.0.0"},
    {:poison, "~> 1.0"},
    {:blazon, ">= 0.0.0"},

    # Encryption
    {:comeonin, "~> 2.4"},
    {:comeonin_ecto_password, "~> 0.0.3"},

    # Database
    {:ecto, "~> 1.0"},
    {:ecto_enum, "~> 0.3.0"},
    {:postgrex, ">= 0.0.0"},

    # Email
    {:swoosh, "~> 0.3.0"}
  ] end

  defp aliases do
    []
  end
end
