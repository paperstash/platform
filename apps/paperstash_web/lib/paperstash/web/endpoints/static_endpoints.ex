defmodule PaperStash.Web.Endpoints.Static do
  @moduledoc ~S"""
  """

  use PaperStash.Web.Routes

  @static :code.priv_dir(:paperstash_web)

  @humans File.read!(Path.join(@static, "/static/humans.txt"))
  @robots File.read!(Path.join(@static, "/static/robots.txt"))

  get "/humans.txt", do: plaintext(@humans)
  get "/robots.txt", do: plaintext(@robots)
end
