defmodule PaperStash.App.Session do
  @moduledoc ~S"""
  """

  defstruct ~w(id owner token started_at expires_at revoked_at)a
end
