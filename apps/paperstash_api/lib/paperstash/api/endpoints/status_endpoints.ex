defmodule PaperStash.Api.Endpoints.Status do
  @moduledoc ~S"""
  """

  use Trot.Router

  get "/v1/status" do
    %{environment: Mix.env,
      node: Node.self,
      # CHORE(mtwilliams): Move into config as this is not available when
      # producing releases.
      version: Mix.Project.config[:version],
      status: "healthy",
      time: :os.system_time(:seconds)}
  end
end
