defmodule Stripe.Mixfile do
  use Mix.Project

  @version "0.7.0-dev"

  def project do
    [app: :stripe,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.11"},
     {:poison, "~> 2.2"},

     # Docs
     {:ex_doc, "~> 0.10", only: :dev},
     {:earmark, "~> 0.1", only: :dev},
     {:inch_ex, ">= 0.0.0", only: :dev}]
  end
end
