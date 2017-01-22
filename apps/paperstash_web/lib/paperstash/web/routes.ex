defmodule PaperStash.Web.Routes do
  @moduledoc ~S"""
  """

  defmacro __using__(_options) do
    quote do
      require Logger
      alias Logger, as: L

      use Plug.Router
      alias Plug.Conn

      import PaperStash.Web.Routes, only: [fallthrough: 0, json: 1]

      plug :match
      plug :dispatch
    end
  end

  defmacro fallthrough do
    quote do
      match _ do
        # We didn't match. Fall through to our router.
        var!(conn)
      end
    end
  end

  defmacro json(response) do
    quote do
      PaperStash.Web.Routes.json(var!(conn), unquote(response))
    end
  end

  def json(conn, response) do
    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.resp(200, Poison.encode!(response))
         |> Plug.Conn.halt
  end
end
