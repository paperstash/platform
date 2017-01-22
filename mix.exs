defmodule PaperStash.Umbrella.Mixfile do
  use Mix.Project

  @apps File.ls!("apps")
        |> Enum.reject(&(String.starts_with?(&1, ".")))
        |> Enum.map(&String.to_atom/1)
        |> Enum.sort

  def project do [
    name: "PaperStash",
    apps_path: "apps",
    build_path: "_build",
    deps_path: "_deps",
    build_embedded: Mix.env() == :prod,
    start_permanent: Mix.env() == :prod,
    deps: deps(),
    aliases: aliases()
  ] end

  defp deps do [
    # Testing
    {:excoveralls, ">= 0.0.0", only: :test},

    # Documentation
    {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
    {:earmark, ">= 0.0.0", only: [:dev, :docs]},
    {:inch_ex, ">= 0.0.0", only: [:dev, :docs]}
  ] end

  defp aliases do [
    start: &start/1
  ] end

  def start([]) do
    Mix.Task.run "app.start", []

    Enum.each(@apps, fn(app) ->
      Mix.shell.info ["==> ", :green, "Starting #{app}..."]
      {:ok, _} = Application.ensure_all_started(app, :permanent)
    end)

    unless iex?, do: :timer.sleep(:infinity)
  end

  defp iex? do
    Code.ensure_loaded?(IEx) && IEx.started?
  end
end
