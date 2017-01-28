defmodule PaperStash.Web.Response do
  @moduledoc ~S"""
  """

  def plaintext(conn, response) do
    conn |> Plug.Conn.put_resp_content_type("text/plain")
         |> Plug.Conn.resp(200, response)
         |> Plug.Conn.halt
  end

  @json_encoder_options pretty: Application.get_env(:knowledge_web, :pretty, true)

  def json(conn, response) do
    conn |> Plug.Conn.put_resp_content_type("application/json")
         |> Plug.Conn.send_resp(200, Poison.encode!(response, @json_encoder_options))
         |> Plug.Conn.halt
  end
end
