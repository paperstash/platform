defmodule PaperStash.Reflection do
  @moduledoc ~S"""
  """

  @types %{
    person: PaperStash.Person,
    user: PaperStash.User,
    token: PaperStash.Token,
    follow: PaperStash.Follow
  }

  for {type, mod} <- @types do
    def type(unquote(mod)), do: unquote(type)
    def type(%unquote(mod){}), do: unquote(type)
    def mod(unquote(type)), do: unquote(mod)
  end

  @serializers %{
    PaperStash.User => PaperStash.UserSerializer,
    PaperStash.Follow => PaperStash.FollowSerializer
  }

  for {mod, serializer} <- @serializers do
    def serializer(unquote(mod)), do: unquote(serializer)
    def serializer(%unquote(mod){}), do: unquote(serializer)
  end
end
