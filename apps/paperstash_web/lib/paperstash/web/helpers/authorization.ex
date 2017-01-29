defmodule PaperStash.Web.Helpers.Authorization do
  @moduledoc ~S"""
  """

  def authorize!(conn, action, resource) do
    unless authorized?(conn, action, resource) do
      raise PaperStash.Web.UnauthorizedError
    end
  end

  def authorized?(conn, action, resource) do
    PaperStash.Authorization.Policy.can?(conn.private[:authentication], action, resource)
  end
end
