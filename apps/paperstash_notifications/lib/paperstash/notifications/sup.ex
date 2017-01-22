defmodule PaperStash.Notifications.Supervisor do
  @moduledoc """
  """

  use Supervisor

  @doc false
  def start_link() do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  @doc false
  def init(_options) do
    supervise([], strategy: :one_for_one)
  end
end
