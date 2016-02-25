defmodule Plug.Redirect do
  @moduledoc """
  A plug for redirecting requests.
  """

  @redirect_codes [301, 302, 303, 307, 308]

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [redirect: 3]
      @before_compile unquote(__MODULE__)
      def init(opts), do: opts
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def call(conn, _opts), do: conn
    end
  end

  defmacro redirect(status, from, to) when status in @redirect_codes do
    quote do
      def call(%Plug.Conn{request_path: unquote(from)} = conn, _opts) do
        conn
        |> Plug.Conn.put_resp_header("location", unquote(to))
        |> Plug.Conn.resp(unquote(status), "You are being redirected.")
        |> Plug.Conn.halt
      end
    end
  end
end
