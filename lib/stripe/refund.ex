defmodule Stripe.Refund do
  use Stripe.API, [:create, :retrieve, :update, :list]

  def endpoint do
    "refunds"
  end
end
