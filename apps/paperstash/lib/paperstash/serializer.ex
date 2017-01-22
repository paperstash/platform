defmodule PaperStash.Serializer do
  @moduledoc ~S"""
  """

  defmacro __using__(_options) do
    quote do
      use Blazon.Serializable

      field :type, via: fn (model) ->
        PaperStash.Reflection.type(model)
      end

      field :id

      field :created_at
      field :updated_at
    end
  end
end
