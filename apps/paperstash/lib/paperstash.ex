defmodule PaperStash do
  @moduledoc ~S"""
  """

  use Application

  @migrations Path.join(:code.priv_dir(:paperstash), "/repo/migrations")

  @doc ~S"""
  """
  def start(_type, _args) do
    # Ensure we have the latest schema.
    {:ok, repo} = PaperStash.Repository.start_link
    Ecto.Migrator.run(PaperStash.Repository, @migrations, :up, all: true)
    GenServer.stop(repo)

    PaperStash.Supervisor.start_link()
  end
end
