defmodule PaperStash.Web.ErrorHandler do
  @moduledoc ~S"""
  Rewrites errors into a standard format, tags with the request identifier, and
  sets an appropriate status code.
  """

  def handle(conn, error) do
    # TODO(mtwilliams): Refactor into a pipeline.
    {status, rewritten} = rewrite(error)
    tagged = Map.put(rewritten, :request, conn.private[:id])
    response = encode(tagged)

    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.send_resp(status, response)
  end

  @pretty Application.get_env(:knowledge_web, :pretty, true)

  defp encode(error) do
    Poison.encode!(error, pretty: @pretty)
  end

  @internal_server_error %{
    error: :internal_server_error,
    details: "Something went wrong!"
  }

  defp rewrite(%{kind: :error, reason: %PaperStash.Web.Error{} = error}) do
    if error.opaque do
      # Don't let anyone know what went wrong.
      {500, @internal_server_error}
    else
      {error.code, %{error: error.name, details: error.details}}
    end
  end

  # TODO(mtwilliams) Don't use `ArgumentError` for bad arguments supplied by
  # clients. Instead, we should raise our own type.
  defp rewrite(%{kind: :error, reason: %ArgumentError{} = error, stack: _stack}) do
    {400, %{error: :parameter, reason: error.message}}
  end

  defp rewrite(%{kind: _kind, reason: _reason, stack: _stack}) do
    {500, @internal_server_error}
  end
end
