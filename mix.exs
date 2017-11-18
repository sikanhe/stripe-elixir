defmodule Stripe.Mixfile do
  use Mix.Project

  @version "0.8.0"

  def project do
    [app: :stripe,
     version: @version,
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     elixirc_paths: elixirc_paths(Mix.env),
     deps: deps(),
     package: package(),
     description: description()]
  end

  def description do
    "Stripe API Client for Elixir"
  end

  def package do
    [
      name: "stripe_elixir",
      maintainers: ["Sikan He"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/sikanhe/stripe-elixir"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:poison, "~> 2.2 or ~> 3.0"},

      # Docs
      {:ex_doc, "~> 0.18.0", only: :dev},
      {:earmark, "~> 1.2.0", only: :dev},
      {:inch_ex, ">= 0.0.0", only: :dev}
    ]
  end
end
