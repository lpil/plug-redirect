defmodule PlugRedirect.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plug_redirect,
      version: "0.1.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,

      name: "PlugRedirect",
      source_url: "https://github.com/lpil/plug-redirect",
      description: "A plug for performing redirects based upon request path.",
      package: [
        maintainers: ["Louis Pilfold"],
        licenses: ["MIT"],
        links: %{ "GitHub" => "https://github.com/lpil/plug-redirect" },
      ]
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
