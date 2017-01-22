defmodule PaperStash.Repository do
  @moduledoc ~S"""
  """

  use Ecto.Repo, otp_app: :paperstash

  alias PaperStash.Repository.Paginator

  def paginate(pageable, request, options \\ []),
    do: Paginator.paginate(pageable, request, options)
end
