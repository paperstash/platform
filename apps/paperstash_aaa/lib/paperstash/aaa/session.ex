defmodule PaperStash.Session do
  @moduledoc ~S"""
  """

  defstruct [:id, :user, :ttl]

  @config Application.get_env(:paperstash_aaa, :sessions)

  @ttl Keyword.get(@config, :ttl)
  def ttl, do: @ttl

  def new(%PaperStash.User{} = user),
    do: new(user.id)

  def new(user),
    do: %__MODULE__{id: UUID.uuid4(), user: user, ttl: @ttl}
end
