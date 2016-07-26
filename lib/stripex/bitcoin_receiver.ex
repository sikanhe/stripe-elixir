defmodule Stripe.BitcoinReceiver do
  use Stripe.API, [:create, :retrieve, :list]

  def endpoint do
    "bitcoin/receivers"
  end
end
