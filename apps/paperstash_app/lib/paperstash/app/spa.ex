defmodule PaperStash.App.Spa do
  @moduledoc ~S"""
  """

  use Trot.Router

  use Trot.Template
  @template_root "#{:code.priv_dir(:paperstash_app)}/templates"

  get "/" do
    render_template("spa.html.eex", [])
  end
end
