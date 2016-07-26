defmodule Stripe.Event do
  use Stripe.API, [:retrieve, :list]

  def endpoint do
    "events"
  end
end
