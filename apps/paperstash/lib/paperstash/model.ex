defmodule PaperStash.Model do
  @moduledoc ~S"""
  """

  @type id :: binary
  @type timestamp :: Timex.DateTime.t | none

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      # Use Universally Unique Identifiers (UUIDs) for all the things!
      # Refer to http://stackoverflow.com/questions/30004008.
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      # Use Timex instead of Ecto for handling dates and times.
      use Timex
      use Timex.Ecto.Timestamps

      # Modify all our schemas...
      defmacro schema(source, [do: block]) do
        # Track when every record was created and updated.
        block = quote do
                  unquote(block)

                  # BUG(mtwilliams): This isn't working.
                  timestamps inserted_at: :created_at,
                              updated_at: :updated_at
                end

        quote do
          Elixir.Schema.schema(unquote(source), [do: unquote(block)])
        end
      end
    end
  end
end
