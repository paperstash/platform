defmodule PaperStash.Web.Error do
  @moduledoc """
  """

  defmacro __using__(_options) do
    quote do
      alias PaperStash.Web.Error, as: Error

      @behaviour Exception
    end
  end

  @type opaqueness :: boolean
  @type code :: non_neg_integer
  @type name :: atom
  @type details :: String.t

  defexception opaque: false,
               code: nil,
               name: nil,
               details: nil

  def exception(details) when is_binary(details) do
    %__MODULE__{opaque: true, code: 500, name: :internal_server_error, details: details}
  end

  def message(%__MODULE__{details: message}), do: message

  def message do
    "Something went wrong!"
  end
end
