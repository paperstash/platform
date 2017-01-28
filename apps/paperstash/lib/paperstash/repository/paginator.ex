defmodule PaperStash.Repository.Paginator do
  @moduledoc ~S"""
  """

  @repository PaperStash.Repository

  @min_per_page 1
  @max_per_page 100

  @spec paginate(any, Keyword.t) :: Scrivener.Page.t

  def paginate(pageable, options) when is_atom(pageable) do
    import Ecto.Query
    q = from entry in pageable, select: entry
    paginate(q, options)
  end

  def paginate(pageable, options \\ []) do
    min_per_page = Keyword.get(options, :min_per_page, @min_per_page)
    max_per_page = Keyword.get(options, :max_per_page, @max_per_page)

    page = Keyword.get(options, :page, 1)
    size = Keyword.get(options, :size, max_per_page)

    cond do
      (size > max_per_page) or (size < min_per_page) ->
        {:error, {:size, :out_of_bounds}}
      (page <= 0) ->
        {:error, {:page, :out_of_bounds}}
      true ->
        config = %Scrivener.Config{module: @repository, page_number: page, page_size: size}
        {:ok, Scrivener.paginate(pageable, config)}
    end
  end

  @spec paginate(any, Keyword.t) :: Scrivener.Page.t | no_return

  def paginate!(pageable, options \\ []) do
    case paginate(pageable, options) do
      {:ok, page} ->
        page
      {:error, {option, :out_of_bounds}} ->
        raise ArgumentError, "`#{option}` is out of bounds"
    end
  end

  def default(:min_per_page), do: @min_per_page
  def default(:max_per_page), do: @max_per_page
end
