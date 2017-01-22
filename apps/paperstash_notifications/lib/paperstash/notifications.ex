defmodule PaperStash.Notifications do
  @moduledoc ~S"""
  """

  use Application

  @doc false
  def start(_type, _args) do
    PaperStash.Notifications.Supervisor.start_link()
  end
end
