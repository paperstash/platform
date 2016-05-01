defmodule PaperStash.App.Endpoints.Sessions do
  @moduledoc ~S"""
  """

  use Trot.Router

  post "/login/via/credentials" do
    case {Map.get(conn.params, "email"), Map.get(conn.params, "password")} do
      {nil, _} ->
        {400, %{error: :missing_credentials, details: "You did not provide an email."}}
      {_, nil} ->
        {400, %{error: :missing_credentials, details: "You did not provide a password."}}
      {email, password} when not(is_binary(email) and is_binary(password)) ->
        {400, %{error: :malformed_credentials, details: "You did not provide a vaild email and/or password."}}
      {email, password} ->
        case PaperStash.User.authenticate(email: email, password: password) do
          {:ok, user} ->
            {501, %{error: :not_implemented_yet}}
          {:error, reason} ->
            # Don't leak our detailed reasoning (for security reasons). Just
            # tell 'em to fuck off.
            {401, %{error: :invalid_credentials, details: "The email and/or password provided are incorrect."}}
        end
    end
  end

  post "/login/via/token" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/login/via/github" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/login/via/twitter" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/login/via/:strategy" do
    {400, %{error: :params, details: "We don't recognize the '#{strategy}' login strategy."}}
  end

  post "/logout" do
    {501, %{error: :not_implemented_yet}}
  end
end
