defmodule PaperStash do
  @moduledoc ~S"""
  """

  use Application

  @doc """
  """
  def start(_type, _args) do
    PaperStash.Supervisor.start_link()
  end
end
