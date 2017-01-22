defmodule PaperStash.Web.Endpoints.Static do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  @humans File.read!(Path.join(:code.priv_dir(:paperstash_web), "/static/humans.txt"))
  @robots File.read!(Path.join(:code.priv_dir(:paperstash_web), "/static/robots.txt"))

  get "/humans.txt", do: message(conn, @humans)
  get "/robots.txt", do: message(conn, @robots)

  defp message(conn, body) do
    conn |> Plug.Conn.put_resp_content_type("text/plain")
         |> Plug.Conn.resp(200, body)
         |> Plug.Conn.halt
  end

  fallthrough
end
