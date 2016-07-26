defmodule Stripe.Recipient do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "recipients"
  end
end
