defmodule PaperStash.Web.NotImplementedError do
  use PaperStash.Web.Error

  def exception([]) do
    %Error{code: 501, name: :not_implemented_yet, details: "Not implemented yet."}
  end
end

defmodule PaperStash.Web.NotSupportedError do
  use PaperStash.Web.Error

  def exception([]), do: exception("Not supported.")
  def exception(details) when is_binary(details) do
    %Error{code: 400, name: :unsupported, details: details}
  end
end

defmodule PaperStash.Web.UnauthorizedError do
  use PaperStash.Web.Error

  def exception([]), do: exception("You're not allowed to do that!")
  def exception(details) when is_binary(details) do
    %Error{code: 403, name: :unauthorized, details: details}
  end
end
