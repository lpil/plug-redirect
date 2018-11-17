defmodule Plug.Redirect.Route do
  @moduledoc """
  Helpers for transforming route strings to ASTs that can be used in
  redirection functions.
  """

  def to_path_info_ast(path) do
    path
    |> String.split("/")
    |> Enum.map(&segment_to_var/1)
  end

  defp segment_to_var(":") do
    ":"
  end

  defp segment_to_var(":" <> segment) do
    var_name = String.to_atom(segment)
    {var_name, [], __MODULE__}
  end

  defp segment_to_var(segment) do
    segment
  end
end
