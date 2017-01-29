defmodule PaperStash.Web.Middleware.FetchQueryParameters do
  @moduledoc ~S"""
  Always fetches query parameters.
  """

  @behaviour Plug

  def init(options) do
    options
  end

  def call(conn, _) do
    conn
    |> Plug.Conn.fetch_query_params
  end
end
