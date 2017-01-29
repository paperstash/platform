defmodule PaperStash.Web.Router do
  @moduledoc ~S"""
  """

  require Logger
  alias Logger, as: L

  @config Application.get_all_env(:paperstash_web) |> Map.new

  if Application.get_env(:paperstash_web, :debugger, false) do
    # TODO(mtwilliams): Specify `PLUG_EDITOR`.
    use Plug.Debugger, otp_app: :paperstash_web
  else
    use Plug.ErrorHandler

    def handle_errors(conn, error),
      do: PaperStash.Web.ErrorHandler.handle(conn, error)
  end

  # HACK(mtwilliams): Middleware is run before our error handlers so certain
  # functionality is retained for `PaperStash.Web.ErrorHandler`.
  use PaperStash.Web.Middleware

  @routes [
    PaperStash.Web.Endpoints.Static,

    PaperStash.Web.Endpoints.Sessions,
    PaperStash.Web.Endpoints.OAuth2,

    PaperStash.Web.Endpoints.Users,

    # We expose a status endpoint only after everything else so that if the
    # aforementioned fuck up and break the pipeline, our status endpoint will
    # fail and we will know something is seriously wrong.
    PaperStash.Web.Endpoints.Status
  ]

  def init(options) do
    options =
      Map.merge(@config, Map.new(options))

    # REFACTOR(mtwilliams): Is this necessary?
    options_for_routes =
      @routes
      |> Enum.map(fn (route) -> {route, apply(route, :init, [options])} end)
      |> Map.new

    {options, options_for_routes}
  end

  def call(conn, {options, options_for_routes}) do
    case try_route(conn, options_for_routes, @routes) do
      %Plug.Conn{state: state} = conn when state in ~W{sent file chunked}a ->
        conn

      %Plug.Conn{state: :set} = conn ->
        L.warn "Response was set but not sent!"
        conn |> Plug.Conn.send_resp

      %Plug.Conn{state: :unset} = conn ->
        # REFACTOR(mtwilliams): Extract?
        conn |> Plug.Conn.put_resp_content_type("text/plain")
             |> Plug.Conn.send_resp(404, "Not found!")
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
end
