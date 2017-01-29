defmodule PaperStash.Web.Endpoints.Sessions do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  alias PaperStash.{Session, SessionStore, SessionSerializer}
  import PaperStash.Authentication

  post "/login/credentials" do
    case {Map.get(conn.params, "email"), Map.get(conn.params, "password")} do
      {nil, _} ->
        json 400, %{error: :credentials, details: "You did not provide an email."}
      {_, nil} ->
        json 400, %{error: :credentials, details: "You did not provide a password."}
      {email, password} when not(is_binary(email) and is_binary(password)) ->
        json 400, %{error: :credentials, details: "You did not provide a vaild email and/or password."}
      {email, password} ->
        case authenticate(email, password) do
          {:ok, user} ->
            session = SessionStore.create(user)
            json Blazon.map(SessionSerializer, session)
          {:error, reason} ->
            # Don't leak our detailed reasoning (for security reasons). Just
            # tell 'em to fuck off. Politely, of course.
            json 401, %{error: :failed, details: "The email and/or password provided are incorrect."}
        end
    end
  end

  post "/login/token" do
    raise NotImplementedError
  end

  post "/login/github" do
    raise NotImplementedError
  end

  post "/login/twitter" do
    raise NotImplementedError
  end

  post "/login/:strategy" do
    raise NotSupportedError, "We don't recognize the `#{strategy}` login strategy."
  end

  post "/logout" do
    raise NotImplementedError
  end
end
