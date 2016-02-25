defmodule Plug.Redirect do
  @moduledoc """
  A plug for redirecting requests.
  """

  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
      def init(opts), do: opts
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def call(conn, _opts), do: conn
    end
  end
end
