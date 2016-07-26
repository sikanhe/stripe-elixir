defmodule Stripex.Subscription do
  use Stripex.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "subscriptions"
  end

  def cancel(id) do
    delete(id)
  end

  def delete_discount(subscription_id) do
    Stripex.request(:delete, "#{endpoint}/#{subscription_id}/discount")
  end
end
