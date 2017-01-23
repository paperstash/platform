defmodule PaperStash.Gravatar do
  @moduledoc """
  Generates [Gravatar](http://gravatar.com) URLs.
  """

  def url(email, options \\ []) do
    %URI{query: []}
    |> host(Keyword.get(options, :secure, true))
    |> path(email)
    |> size(Keyword.get(options, :size, 256))
    |> fallback(Keyword.get(options, :fallback, :none))
    |> encode
    |> URI.to_string
  end

  defp host(uri, true),
    do: %URI{uri | scheme: "https", host: "gravatar.com"}
  defp host(uri, false),
    do: %URI{uri | scheme: "http", host: "gravatar.com"}

  defp path(uri, email) do
    hash = :crypto.hash(:md5, email)
           |> Base.encode16(case: :lower)

    %URI{uri | path: "/avatar/#{hash}"}
  end

  defp size(uri, size) when is_integer(size),
    do: %URI{uri | query: [{:s, size} | uri.query]}

  defp fallback(uri, :none),
    do: %URI{uri | query: [{:d, 404} | uri.query]}
  defp fallback(uri, method) when method in ~W{blank identicon}a,
    do: %URI{uri | query: [{:d, method} | uri.query]}

  defp encode(uri),
    do: %URI{uri | query: URI.encode_query(uri.query)}
end
