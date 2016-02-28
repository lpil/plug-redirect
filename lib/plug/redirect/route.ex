defmodule Plug.Redirect.Route do
  @moduledoc """
  Helpers for transforming route strings to ASTs that can be used in
  redirection functions.
  """

  @spec to_path_info_ast(String.t) :: [String.t]

  def to_path_info_ast(path) do
    path
    |> String.split("/")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&transform_variable_segment/1)
  end

  defp transform_variable_segment(":") do
    ":"
  end
  defp transform_variable_segment(":" <> segment) do
    var_name = String.to_atom(segment)
    {var_name, [], __MODULE__}
  end
  defp transform_variable_segment(segment) do
    segment
  end
end
