defmodule PaperStash.Reflection do
  @moduledoc ~S"""
  """

  @types %{
    person: PaperStash.Person,
    user: PaperStash.User,
    token: PaperStash.Token
  }

  for {type, mod} <- @types do
    def type(unquote(mod)), do: unquote(type)
    def type(%unquote(mod){}), do: unquote(type)
    def mod(unquote(type)), do: unquote(mod)
  end
end
