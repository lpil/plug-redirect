defmodule Plug.Redirect do
  @moduledoc """
  A plug builder for redirecting requests.
  """

  alias Plug.Redirect.Route

  @redirect_codes [301, 302, 303, 307, 308]

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [redirect: 3, redirect: 2]
      @before_compile unquote(__MODULE__)
      def init(opts), do: opts
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def call(conn, _opts), do: conn
    end
  end


  @doc """
  Specify a redirect.

  The first argument is the 30x redirect HTTP status code to use. 301, 302,
  etc.

  The second argument is the request to match upon for the redirect. It must
  begin with a "/".

  The third argument is the location to redirect the request to.
  """
  defmacro redirect(status, from, to) when status in @redirect_codes do
    segments = Route.to_path_info_ast(from)
    quote do
      def call(%Plug.Conn{path_info: unquote(segments)} = conn, _opts) do
        conn
        |> Plug.Conn.put_resp_header("location", unquote(to))
        |> Plug.Conn.resp(unquote(status), "You are being redirected.")
        |> Plug.Conn.halt
      end
    end
  end

  @doc """
  The same as redirect/3, only with a default status code of 301.
  """
  defmacro redirect(from, to) do
    quote do
      redirect(301, unquote(from), unquote(to))
    end
  end
end
