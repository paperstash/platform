defmodule PaperStash.Repository do
  @moduledoc ~S"""
  """

  use Ecto.Repo, otp_app: :paperstash

  alias PaperStash.Repository.Paginator

  def paginate(pageable, request, options \\ []),
    do: Paginator.paginate(pageable, request, options)

  def paginate!(pageable, request, options \\ []) do
    case paginate(pageable, request, options) do
      {:ok, page} ->
        page
      {:error, details} ->
        raise ArgumentError, details
    end
  end
end
