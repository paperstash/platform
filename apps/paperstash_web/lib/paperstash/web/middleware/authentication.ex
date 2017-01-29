defmodule PaperStash.Web.Middleware.Authentication do
  @moduledoc ~S"""
  Checks and validates authentication if provided.
  """

  @behaviour Plug

  alias Plug.Conn

  def init(options) do
    options
  end

  def call(conn, options) do
    case Conn.get_req_header(conn, "authorization") do
      [authentication | _] ->
        case authenticate(authentication) do
          {:ok, authentication} ->
            conn |> Conn.put_private(:authentication, authentication)
          {:error, reason} ->
            response = %{error: :authentication, details: reason_to_message(reason)}
            tagged = Map.put(response, :request, conn.private[:id])
            conn |> PaperStash.Web.Helpers.Response.json(401, tagged)
        end
      _ ->
        ip = conn.remote_ip |> :inet.ntoa |> to_string
        conn |> Conn.put_private(:authentication, %PaperStash.Anonymous{ip: ip})
    end
  end

  defp reason_to_message(:invalid), do: "Invalid or expired credentials."
  defp reason_to_message(:malformed), do: "Malformed credentials."
  defp reason_to_message(:unsupported), do: "Unsupported authentication method!"

  defp authenticate(authentication) do
    case String.split(authentication, parts: 2) do
      ["Basic", encoded] ->
        authenticate_with_session(encoded)
      ["Bearer", token] ->
        authenticate_with_token(token)
      [method, _] ->
        {:error, :unsupported}
    end
  end

  alias PaperStash.{User, Session, SessionStore}
  alias PaperStash.Repository, as: R

  defp authenticate_with_session(encoded) do
    case Base.decode64(encoded) do
      {:ok, decoded} ->
        case String.split(decoded, ":", parts: 2) do
          [id, _] ->
            if session = SessionStore.find(id) do
              {:ok, R.get!(User, session.user)}
            else
              {:error, :invalid}
            end
          _ ->
            {:error, :malformed}
        end
      :error ->
        {:error, :malformed}
    end
  end

  defp authenticate_with_token(token) do
    {:error, :unsupported}
  end
end
