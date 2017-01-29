defmodule PaperStash.Authorization.Policy do
  @moduledoc ~S"""
  """

  alias PaperStash.Web.Anonymous, as: Anonymous
  alias PaperStash.User, as: User

  @public [PaperStash.User]

  def can?(_, :read, resource)
    when resource in @public, do: true

  def can?(_, :read, %{__struct__: type})
    when type in @public, do: true

  def can?(subject, action, resource), do: false
end
