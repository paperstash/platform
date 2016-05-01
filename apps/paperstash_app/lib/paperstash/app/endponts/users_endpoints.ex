defmodule PaperStash.App.Endpoints.Users do
  @moduledoc ~S"""
  """

  use Trot.Router

  post "/join" do
    user =
      Map.take(conn.body_params, ~w(name nickname email password))
      |> Enum.map(&({String.to_atom(elem(&1,0)), elem(&1,1)}))
      |> PaperStash.User.create

    PaperStash.UserEmail.welcome(user)
    |> PaperStash.Emailer.deliver

    # TODO(mtwilliams): Return a session.
    {200, %{}}
  end

  post "/email/verify" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/email/verify/request" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/password/reset" do
    {501, %{error: :not_implemented_yet}}
  end

  post "/password/reset/request" do
    {501, %{error: :not_implemented_yet}}
  end
end
