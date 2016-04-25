defmodule PaperStash.Umbrella.Mixfile do
  use Mix.Project

  @apps File.ls!("apps")
        |> Enum.map(&String.to_atom/1)
        |> Enum.sort

  def project do
    [name: "PaperStash",
     version: version,
     elixir: "~> 1.0",
     description: "A completely free and open repository for all papers and presentations relevant to game development.",
     homepage_url: "https://paperstash.org/",
     source_url: "https://github.com/paperstash/paperstash",
     apps_path: "apps",
     build_path: "_build",
     deps_path: "_deps",
     lockfile: "mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     aliases: aliases]
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

  defp deps do
    []
  end

  defp aliases do
    [start: &start/1]
  end

  def start([]) do
    Mix.Task.run "app.start", []

    Enum.each(@apps, fn(app) ->
      Mix.shell.info ["==> ", :green, "Starting #{app}..."]
      Application.ensure_all_started(app, :permanent)
    end)

    unless iex?, do: :timer.sleep(:infinity)
  end

  defp iex? do
    Code.ensure_loaded?(IEx) && IEx.started?
  end
end
