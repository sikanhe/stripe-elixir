defmodule Stripe.CountrySpec do
  use Stripe.API, [:retrieve, :list]

  def endpoint do
    "country_specs"
  end
end
