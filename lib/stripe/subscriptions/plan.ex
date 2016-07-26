defmodule Stripe.Plan do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "plans"
  end
end
