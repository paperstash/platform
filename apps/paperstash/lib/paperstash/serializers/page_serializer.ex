defmodule PaperStash.PageSerializer do
  @moduledoc ~S"""
  """

  import PaperStash.Reflection, only: [serializer: 1]

  def map(page, options \\ []) do
    name_of_collection = Keyword.get(options, :name, :entries)

    serializer = Keyword.get(options, :serializer, &serialize/1)

    entries = page.entries
           |> Enum.map(serializer)

    page = %{total: page.total_entries,
             page: page.page_number,
             pages: page.total_pages,
             per: page.page_size}

    page = Map.put(page, name_of_collection, entries)

    page
  end

  def json(page, options \\ []) do
    map(page, options) |> Poison.encode!
  end

  defp serialize(entry) do
    Blazon.map(serializer(entry), entry)
  end
end
