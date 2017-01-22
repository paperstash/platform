defmodule PaperStash.Web.NotImplementedError do
  @behaviour Exception

  def exception([]) do
    %PaperStash.Web.Error{
      opaque: false,
      code: 501,
      name: :not_implemented_yet,
      details: "Not implemented yet."
    }
  end

  def message(error), do: error.details
end

defmodule PaperStash.Web.NotSupportedError do
  @moduledoc ~S"""
  """

  @behaviour Exception

  def exception([]), do: exception("Not supported.")
  def exception(details) when is_binary(details) do
    %PaperStash.Web.Error{
      opaque: false,
      code: 400,
      name: :unsupported,
      details: details
    }
  end

  def message(error), do: error.details
end
