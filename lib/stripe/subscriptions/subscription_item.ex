defmodule Stripe.SubscriptionItem do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "subscription_items"
  end
end
