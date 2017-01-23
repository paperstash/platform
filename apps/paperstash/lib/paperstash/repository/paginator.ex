defmodule PaperStash.Repository.Paginator do
  @moduledoc ~S"""
  """

  @min_per_page 1
  @max_per_page 100

  @spec paginate(any, map | Keyword.t, Keyword.t) :: Scrivener.Page.t
  def paginate(pageable, request, options \\ []) do
    case params_to_config(Map.new(request), options) do
      {:ok, config} ->
        {:ok, Scrivener.paginate(pageable, config)}
      error ->
        error
    end
  end

  defp params_to_config(request, options) do
    min_per_page = Keyword.get(options, :min, @min_per_page)
    max_per_page = Keyword.get(options, :max, @max_per_page)

    case {param_to_int(Map.get(request, "page", 1)),
          param_to_int(Map.get(request, "per", max_per_page))} do
      {:error, _} ->
        {:error, "Expected `page` to be an integer."}
      {{page, _}, _} when page <= 0 ->
        {:error, "Expected `page` to be an integer above 0."}
      {_, :error} ->
        {:error, "Expected `per` to be an integer."}
      {_, {per, _}} when (per > max_per_page) or (per < min_per_page) ->
        {:error, "Expected `per` to be an integer in [#{min_per_page}, #{max_per_page}]."}
      {{page, _}, {per, _}} ->
        {:ok, %Scrivener.Config{module: PaperStash.Repository, page_number: page, page_size: per}}
    end
  end

  defp param_to_int(v) when is_integer(v), do: {v, ""}
  defp param_to_int(v) when is_binary(v), do: Integer.parse(v)
  defp param_to_int(_), do: :error
end
