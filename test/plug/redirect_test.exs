defmodule Plug.RedirectTest do
  use ExUnit.Case
  use Plug.Test

  defmodule MyPlug do
    use Plug.Redirect

    redirect("/foo/bar", "/go/here", status: 301)
    redirect("/jump/up", "/get/down", status: 302)
    redirect("/ra/wavy", "/by/droid", status: 303)
    redirect("/rock/on", "/roll/out", status: 307)

    redirect("/no/status", "/301/default")

    redirect("/blog/:slug", "/no-more-blog")
    redirect("/users/:slug", "/profile/:slug")
    redirect("/other/:slug", "http://somewhere.com/profile/:slug")

    # Old API
    redirect(301, "/old/foo/bar", "/go/here")
    redirect(302, "/old/jump/up", "/get/down")
    redirect(303, "/old/ra/wavy", "/by/droid")
    redirect(307, "/old/rock/on", "/roll/out")
  end

  @opts MyPlug.init([])
  @methods ~w(get head post put delete trace options connect patch)a

  for method <- @methods do
    test "it passes through when no redirects match a #{method}" do
      conn = unquote(method) |> conn("/hello")
      result = conn |> MyPlug.call(@opts)
      assert conn == result
    end
  end

  test "it can perform 301 redirects" do
    conn = get("/foo/bar")
    assert_redirect(conn, 301, "/go/here")
  end

  test "it can perform 302 redirects" do
    conn = get("/jump/up")
    assert_redirect(conn, 302, "/get/down")
  end

  test "it can perform 303 redirects" do
    conn = get("/ra/wavy")
    assert_redirect(conn, 303, "/by/droid")
  end

  test "it can perform 307 redirects" do
    conn = get("/rock/on")
    assert_redirect(conn, 307, "/roll/out")
  end

  describe "backwards compatibility with old API" do
    test "it can perform 301 redirects" do
      conn = get("/old/foo/bar")
      assert_redirect(conn, 301, "/go/here")
    end

    test "it can perform 302 redirects" do
      conn = get("/old/jump/up")
      assert_redirect(conn, 302, "/get/down")
    end

    test "it can perform 303 redirects" do
      conn = get("/old/ra/wavy")
      assert_redirect(conn, 303, "/by/droid")
    end

    test "it can perform 307 redirects" do
      conn = get("/old/rock/on")
      assert_redirect(conn, 307, "/roll/out")
    end
  end

  test "when given no status it defaults to 301" do
    conn = get("/no/status")
    assert_redirect(conn, 301, "/301/default")
  end

  test "variable sections can exist" do
    conn = get("/blog/some-article")
    assert_redirect(conn, 301, "/no-more-blog")
    conn = get("/blog/another-article")
    assert_redirect(conn, 301, "/no-more-blog")
  end

  test "other hosts can be redirected to" do
    conn = get("/other/louis")
    assert_redirect(conn, 301, "http://somewhere.com/profile/louis")
  end

  defp get(path) do
    :get |> conn(path) |> MyPlug.call(@opts)
  end

  defp assert_redirect(conn, code, to) do
    assert conn.state == :set
    assert conn.status == code
    assert Plug.Conn.get_resp_header(conn, "location") == [to]
  end
end
