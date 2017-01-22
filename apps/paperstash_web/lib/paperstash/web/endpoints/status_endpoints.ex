defmodule PaperStash.Web.Endpoints.Status do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  get "/v1/status" do
    # CHORE(mtwilliams): Move into config as this is not available when
    # producing releases.
    json %{
      environment: Mix.env,
      node: Node.self,
      version: Mix.Project.config[:version],
      status: :healthy,
      time: :os.system_time(:seconds)
    }
  end

  fallthrough
end
