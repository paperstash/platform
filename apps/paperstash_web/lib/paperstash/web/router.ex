defmodule PaperStash.Web.Router do
  @moduledoc ~S"""
  """

  require Logger
  alias Logger, as: L

  use Plug.Builder

  @config Application.get_env(:paperstash_web, PaperStash.Web.Router, %{})
          |> Map.new

  plug PaperStash.Web.RequestIdentifier

  if Map.get(@config, :debugger, false) do
    # TODO(mtwilliams): Specify `PLUG_EDITOR`.
    use Plug.Debugger, otp_app: :paperstash_web
  else
    use Plug.ErrorHandler
  end

  plug Plug.Logger, log: :info

  plug PaperStash.Web.ExpandQueryParameters

  plug Plug.Parsers, parsers: [:urlencoded, :multipart, :json],
                     pass: ["application/*", "text/*"],
                     json_decoder: Poison

  @routes [
    PaperStash.Web.Endpoints.Static,

    # We expose a status endpoint only after everything else so that if the
    # aforementioned fuck up and break the pipeline, our status endpoint will
    # fail and we will know something is seriously wrong.
    PaperStash.Web.Endpoints.Status
  ]

  def init(options) do
    options =
      Map.merge(@config, Map.new(options))

    options_for_routes =
      @routes
      |> Enum.map(fn (route) -> {route, apply(route, :init, [options])} end)
      |> Map.new

    {options, options_for_routes}
  end

  def call(conn, {options, options_for_routes}) do
    conn = super(conn, options)

    case try_route(conn, options_for_routes, @routes) do
      %Plug.Conn{halted: false} = conn -> not_found(conn)
      %Plug.Conn{state: :unset} = conn -> not_found(conn)
      %Plug.Conn{state: :set} = conn -> Plug.Conn.send_resp(conn)
      conn -> conn
    end
  end

  # OPTIMIZE(mtwilliams): Use metaprogramming to reduce the stupid.
  defp try_route(conn, _, []), do: conn
  defp try_route(conn, options_for_routes, [candidate | remaining]) do
    options_for_candidate = Map.get(options_for_routes, candidate, [])
    case apply(candidate, :call, [conn, options_for_candidate]) do
      %Plug.Conn{halted: true} = conn -> conn
      %Plug.Conn{state: state} = conn when (state != :unset) -> conn
      _ -> try_route(conn, options_for_routes, remaining)
    end
  end

  defp not_found(conn) do
    conn |> Plug.Conn.put_resp_content_type("text/plain")
         |> Plug.Conn.resp(404, "Not found!")
  end

  # Production error handler.

  @internal_server_error %{error: :internal_server_error, details: "Something went wrong!"}

  def handle_errors(conn, %{kind: :error, reason: %PaperStash.Web.Error{} = error}) do
    {code, response} =
      if error.opaque do
        # Don't let anyone know what went wrong.
        {500, @internal_server_error}
      else
        {error.code, %{error: error.name, details: error.details}}
      end

    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.send_resp(code, Poison.encode!(response))
  end

  def handle_errors(conn, %{kind: :error, reason: %ArgumentError{} = error, stack: _stack}) do
    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.send_resp(400, Poison.encode!(%{error: :parameter, reason: error.message}))
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.send_resp(500, Poison.encode!(@internal_server_error))
  end
end
