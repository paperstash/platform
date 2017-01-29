defmodule PaperStash.Web.Routes do
  @moduledoc ~S"""
  """

  defmacro __using__(_options) do
    quote do
      @before_compile PaperStash.Web.Routes

      use Plug.Router

      import PaperStash.Web.Routes, only: [plaintext: 1, plaintext: 2,
                                           json: 1, json: 2,
                                           paginate: 1, paginate: 2]

      alias PaperStash.Web.{NotImplementedError,
                            NotSupportedError}

      plug :match
      plug :dispatch
    end
  end

  defmacro __before_compile__(_options) do
    quote do
      match _ do
        # We didn't match. Fall through to our router.
        var!(conn)
      end
    end
  end

  # TODO(mtwilliams): Detect `__struct__` and serialize prior to encoding.

  defmacro plaintext(status, response) do
    quote do
      PaperStash.Web.Helpers.Response.plaintext(var!(conn), unquote(status), unquote(response))
    end
  end

  defmacro plaintext(response) do
    quote do
      PaperStash.Web.Helpers.Response.plaintext(var!(conn), unquote(response))
    end
  end

  defmacro json(status, response) do
    quote do
      PaperStash.Web.Helpers.Response.json(var!(conn), unquote(status), unquote(response))
    end
  end

  defmacro json(response) do
    quote do
      PaperStash.Web.Helpers.Response.json(var!(conn), unquote(response))
    end
  end

  defmacro paginate(pageable, options \\ []) do
    quote do
      PaperStash.Web.Routes.paginate(var!(conn), unquote(pageable), unquote(options))
    end
  end

  alias PaperStash.PageSerializer

  def paginate(conn, pageable, options) do
    page = PaperStash.Web.Helpers.Pagination.paginate!(conn, pageable, options)
    response = PageSerializer.map(page, options)
    response
  end
end
