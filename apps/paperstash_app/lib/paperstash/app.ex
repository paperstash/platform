defmodule PaperStash.App do
  @moduledoc ~S"""
  """

  use Application

  @doc false
  def start(_type, _args) do
    PaperStash.App.Supervisor.start_link()
  end
end
