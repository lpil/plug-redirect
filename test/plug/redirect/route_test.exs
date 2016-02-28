defmodule Plug.Redirect.RouteTest do
  use ExUnit.Case

  alias Plug.Redirect.Route

  test "to_path_info_ast" do
    ast = Route.to_path_info_ast("/foo/bar")
    assert ast == ["", "foo", "bar"]
  end

  test "to_path_info_ast with variable section" do
    ast = Route.to_path_info_ast("/foo/:bar")
    assert ["", "foo", {:bar, [], _}] = ast
  end
end
