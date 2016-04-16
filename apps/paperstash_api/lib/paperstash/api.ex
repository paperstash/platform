defmodule PaperStash.Api do
  @moduledoc ~S"""
  """

  use Application

  @doc false
  def start(_type, _args) do
    PaperStash.Api.Supervisor.start_link()
  end
end
