defmodule PaperStash.SessionSerializer do
  @moduledoc ~S"""
  """

  use Blazon.Serializable

  field :type, via: fn _ -> :session end

  field :id
  field :user
  field :ttl
end
