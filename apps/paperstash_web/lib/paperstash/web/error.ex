defmodule PaperStash.Web.Error do
  @moduledoc """
  """

  @type opaqueness :: boolean
  @type code :: non_neg_integer
  @type name :: atom
  @type details :: String.t

  defexception opaque: true,
               code: nil,
               name: nil,
               details: nil

  def exception(details) when is_binary(details) do
    %__MODULE__{opaque: true, code: 500, name: :internal_server_error, details: details}
  end

  def message do
    "Something went wrong!"
  end
end
