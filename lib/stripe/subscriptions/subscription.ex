defmodule Stripe.Subscription do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "subscriptions"
  end

  def delete_discount(subscription_id) do
    Stripe.request(:delete, "#{endpoint}/#{subscription_id}/discount")
  end

  def delete(subscription_id, options) do
    Stripe.request(:delete, "#{endpoint}/#{subscription_id}", options)
  end
end
