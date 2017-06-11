defmodule GildedRose.Mixfile do
  use Mix.Project

  def project do
    [app: :gilded_rose,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps()]
  end

  defp deps do
    [{:mix_test_watch, "~> 0.3", only: :dev, runtime: false}]
  end
end
