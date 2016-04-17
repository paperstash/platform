defmodule PaperStash.App.Sessions do
  @moduledoc ~S"""
  """

  use Trot.Router

  post "/login/via/email" do
    %{}
  end

  post "/login/via/token" do
    %{}
  end

  post "/login/via/github" do
    {501, %{error: :unimplemented}}
  end

  post "/login/via/twitter" do
    {501, %{error: :unimplemented}}
  end

  post "/login/via/:strategy" do
    {400, %{error: :params, details: "We don't recognize the '#{strategy}' login strategy."}}
  end

  post "/logout" do
    %{}
  end
end
