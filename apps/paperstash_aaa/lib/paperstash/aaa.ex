defmodule PaperStash.AAA do
  @moduledoc ~S"""
  """

  use Application

  @doc false
  def start(_type, _args) do
    PaperStash.AAA.Supervisor.start_link()
  end
end
