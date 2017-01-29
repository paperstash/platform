defmodule PaperStash.Web.Middleware do
  @moduledoc ~S"""
  """

  use Plug.Builder

  # We assign an request identifier as soon as possible to making tracking
  # issues easier. We also make sure to do so before `Plug.Logger` is called,
  # otherwise its messages aren't tied to their respective requests.

  plug PaperStash.Web.Middleware.RequestIdentifier

  plug Corsica, origins: "*",
                allow_credentials: true,
                allow_headers: ~W{Accept Accept-Language Content-Type Content-Language},
                allow_methods: ~W{OPTIONS HEAD GET POST PUT PATCH DELETE LINK UNLINK},
                max_age: 60

  plug Plug.Logger, log: :info

  # We always fetch query parameters and parse request bodies upfront.

  plug PaperStash.Web.Middleware.FetchQueryParameters

  plug Plug.Parsers, parsers: [:urlencoded, :multipart, :json],
                     pass: ["application/*", "text/*"],
                     json_decoder: Poison

  # Injection helpers. See `PaperStash.Web.Router`.

  defmacro __using__(_options) do
    quote do
      @before_compile PaperStash.Web.Middleware
    end
  end

  defmacro __before_compile__(_options) do
    quote do
      defoverridable [call: 2]

      def call(conn, options) do
        super(PaperStash.Web.Middleware.call(conn, options), options)
      end
    end
  end
end
