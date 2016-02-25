defmodule PlugRedirect.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plug_redirect,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:plug, ">= 1.0.0"},
      {:dogma, ">= 0.0.0", only: [:dev, :test]},
      {:mix_test_watch, ">= 0.0.0", only: :dev},
    ]
  end
end
