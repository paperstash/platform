defmodule PaperStash.Web.Supervisor do
  @moduledoc """
  """

  use Supervisor

  @config Application.get_env(:paperstash_web, PaperStash.Web.Router, [])

  @doc false
  def start_link() do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  @doc false
  def init(_options) do
    config = [
      port: Keyword.get(@config, :port, 4000)
    ]

    children = [
      # TODO(mtwilliams): Pass options from configuration.
      Plug.Adapters.Cowboy.child_spec(:http, PaperStash.Web.Router, [], config)
    ]

    supervise(children, strategy: :one_for_one)
  end
end
