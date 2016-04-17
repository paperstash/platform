defmodule PaperStash.App.Session do
  @moduledoc ~S"""
  """

  defstruct ~w(id owner started_at expires_at revoked_at)a
end
