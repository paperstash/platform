defmodule PaperStash.Web.Pagination do
  @moduledoc ~S"""
  """

  alias PaperStash.Repository.Paginator

  # TODO(mtwilliams): Replace `ArgumentError` with custom error type.

  def paginate!(conn, pageable, options \\ []) do
    min_per_page = Map.get(conn.params, :min_per_page, Paginator.default(:min_per_page))
    max_per_page = Map.get(conn.params, :max_per_page, Paginator.default(:max_per_page))

    case paginate(conn, pageable, options) do
      {:ok, page} ->
        page
      {:error, {:size, :out_of_bounds}} ->
        raise ArgumentError, "Expected `per_page` to be an integer between [#{min_per_page}, #{max_per_page}]."
      {:error, {:page, :out_of_bounds}} ->
        raise ArgumentError, "Expected `page` to be an integer above 0 and less than or equal to the maximum."
      {:error, {param, :unparseable}} ->
        raise ArgumentError, "Expected `#{param}` to be an integer."
    end
  end

  def paginate(conn, pageable, options \\ []) do
    with {:ok, options_from_request} <- params_to_options(conn.params, options),
         {:ok, page} <- Paginator.paginate(pageable, Keyword.merge(options, options_from_request)),
      do: {:ok, page}
  end

  defp params_to_options(params, options) do
    max_per_page = Map.get(params, :max_per_page, Paginator.default(:max_per_page))

    case {Map.get(params, "page", 1) |> param_to_int,
          Map.get(params, "per_page", max_per_page) |> param_to_int} do
      {:error, _} ->
        {:error, {:page, :unparseable}}
      {_, :error} ->
        {:error, {:per_page, :unparseable}}
      {{page, _}, {per_page, _}} ->
        {:ok, [page: page, size: per_page]}
    end
  end

  defp param_to_int(v) when is_integer(v), do: {v, ""}
  defp param_to_int(v) when is_binary(v), do: Integer.parse(v)
  defp param_to_int(_), do: :error
end
