defmodule PaperStash.Notifications.Mixfile do
  use Mix.Project

  def project do [
    app: :paperstash_notifications,
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
    mod: {PaperStash.Notifications, []},
    # applications: ~W{logger paperstash}a,
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
    # Umbrella
    {:paperstash, in_umbrella: true},

    # Email
    {:swoosh, ">= 0.0.0"},

    # HACK(mtwilliams): We need to depend on Plug so that Swoosh's mailbox
    # preview functionality is compiled in, as it only compiles in if Plug is
    # available.
    {:plug, ">= 0.0.0"}
  ] end

  defp aliases do [
  ] end
end
