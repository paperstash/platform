defmodule PaperStash.App.Users do
  @moduledoc ~S"""
  """

  use Trot.Router

  post "/join" do
    %{}
  end

  post "/email/verify" do
    {501, %{error: :unimplemented}}
  end

  post "/email/verify/request" do
    {501, %{error: :unimplemented}}
  end

  post "/password/reset" do
    {501, %{error: :unimplemented}}
  end

  post "/password/reset/request" do
    {501, %{error: :unimplemented}}
  end
end
