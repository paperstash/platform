defmodule PaperStash.Serializer do
  @moduledoc ~S"""
  """

  defmacro __using__(_opts) do
    quote do
      use Blazon.Serializable

      field :id

      field :created_at
      field :updated_at
    end
  end
end
