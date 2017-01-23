defmodule PaperStash.Model do
  @moduledoc """
  """

  @type id :: binary
  @type timestamp :: Timex.DateTime.t | none

  defmacro __using__(opts \\ []) do
    quote do
      import PaperStash.Model, only: [schema: 2, schema: 3, pseudo: 1]

      use Ecto.Schema
      import Ecto.Schema, except: [schema: 2, embedded_schema: 1]

      import Ecto.Query
      import Ecto.Changeset

      alias PaperStash.Repository, as: R

      # Use Universally Unique Identifiers (UUIDs) for all the things!
      # Read http://stackoverflow.com/questions/30004008
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      # Use Timex instead of Ecto for handling dates and times.
      use Timex
      use Timex.Ecto.Timestamps, inserted_at: :created_at,
                                 updated_at: :updated_at
    end
  end

  defmacro schema(source, [do: block]) do
    quote do
      schema(unquote(source), [], [do: unquote(block)])
    end
  end

  defmacro schema(source, options, [do: block]) do
    # Every one of our models has timestamps by default.
    timestamped = Keyword.get(options, :timestamped, true)

    block = quote do
      unquote(block)

      if unquote(timestamped) do
        # Inject timestamps.
        timestamps()
      end
    end

    quote do
      Ecto.Schema.schema(unquote(source), [do: unquote(block)])
    end
  end

  defmacro pseudo(_source) do
    quote do "" end
  end
end
