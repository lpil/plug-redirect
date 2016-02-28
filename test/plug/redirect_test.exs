defmodule Plug.RedirectTest do
  use ExUnit.Case
  use Plug.Test

  defmodule MyPlug do
    use Plug.Redirect

    redirect 301, "/foo/bar", "/a/redirect"
    redirect 302, "/jump/up", "/get/down"
    redirect 303, "/ra/wavy", "/by/droid"
    redirect 307, "/rock/on", "/roll/out"

    redirect "/no/status", "/301/default"

    redirect "/blog/:slug", "/no-more-blog"
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

  test "it can perform 301 redirects" do
    conn = :get |> conn("/foo/bar") |> MyPlug.call(@opts)
    assert_redirect(conn, 301, "/a/redirect")
  end

  test "it can perform 302 redirects" do
    conn = :get |> conn("/jump/up") |> MyPlug.call(@opts)
    assert_redirect(conn, 302, "/get/down")
  end

  test "it can perform 303 redirects" do
    conn = :get |> conn("/ra/wavy") |> MyPlug.call(@opts)
    assert_redirect(conn, 303, "/by/droid")
  end

  test "it can perform 307 redirects" do
    conn = :get |> conn("/rock/on") |> MyPlug.call(@opts)
    assert_redirect(conn, 307, "/roll/out")
  end

  test "when given no status it defaults to 301" do
    conn = :get |> conn("/no/status") |> MyPlug.call(@opts)
    assert_redirect(conn, 301, "/301/default")
  end


  defp assert_redirect(conn, code, to) do
    assert conn.state == :set
    assert conn.status == code
    assert Plug.Conn.get_resp_header(conn, "location") == [to]
  end
end
