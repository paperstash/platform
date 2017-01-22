defmodule PaperStash.Web do
  @moduledoc ~S"""
  """

  use Application

  @doc false
  def start(_type, _args) do
    PaperStash.Web.Supervisor.start_link()
  end
end
