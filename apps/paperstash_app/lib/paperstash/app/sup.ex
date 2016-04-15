defmodule PaperStash.App.Supervisor do
  @moduledoc """
  """

  use Supervisor

  @doc false
  def start_link() do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  @doc false
  def init(_) do
    children = [
      # TODO(mtwilliams): Pass-thru options from configuration.
      Plug.Adapters.Cowboy.child_spec(:http, PaperStash.App.Router, [], [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
