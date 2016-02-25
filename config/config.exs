use Mix.Config

if Mix.env == :dev do
  config :mix_test_watch, tasks: ~w(test dogma)
end
