defmodule Plug.RedirectTest do
  use ExUnit.Case
  use Plug.Test

  defmodule MyPlug do
    use Plug.Redirect
  end

  @opts MyPlug.init([])
  @methods ~w(get head post put delete trace options connect patch)a

  for method <- @methods do
    test "it passes through when no redirects match a #{method}" do
      conn   = unquote(method) |> conn("/hello")
      result = conn |> MyPlug.call(@opts)
      assert conn == result
    end
  end
end
