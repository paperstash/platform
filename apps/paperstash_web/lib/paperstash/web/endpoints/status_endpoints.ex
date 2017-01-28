defmodule PaperStash.Web.Endpoints.Status do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  @environment Mix.env
  @version Mix.Project.config[:version]

  get "/v1/status" do
    json %{
      environment: @environment,
      node: Node.self,
      version: @version,
      status: :healthy,
      time: :os.system_time(:seconds)
    }
  end
end
