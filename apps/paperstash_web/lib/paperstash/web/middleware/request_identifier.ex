defmodule PaperStash.Web.RequestIdentifier do
  @moduledoc ~S"""
  Our version of `Plug.RequestId` that only accepts UUIDs.
  """

  @behaviour Plug

  require Logger
  alias Logger, as: L

  alias Plug.Conn

  def init(options) do
    Keyword.get(options, :http_header, "x-request-id")
  end

  def call(conn, header) do
    conn
    |> get_request_identifier(header)
    |> set_request_identifier(header)
  end

  defp get_request_identifier(conn, header) do
    case Conn.get_req_header(conn, header) do
      [] ->
        # No identifier provided; generate one.
        {conn, generate_request_identifier()}

      [identifier | _] ->
        if valid_request_identifer?(identifier) do
          {conn, identifier}
        else
          L.debug "Ingoring provided request identifier because it's invalid!"
          {conn, generate_request_identifier()}
        end
    end
  end

  defp set_request_identifier({conn, identifier}, header) do
    L.metadata(request: identifier)
    Conn.put_resp_header(conn, header, identifier)
  end

  defp generate_request_identifier do
    UUID.uuid4()
  end

  defp valid_request_identifer?(id) when is_binary(id) do
    # HACK(mtwilliams): Rather that we pattern match...
    try do
      UUID.info!(id)
    rescue
      ArgumentError ->
        false
    else
      _ ->
        true
    end
  end

  defp valid_request_identifer?(id), do: false
end
