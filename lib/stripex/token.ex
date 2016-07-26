defmodule Stripe.Token do
  use Stripe.API, [:create, :retrieve]

  def endpoint do
    "tokens"
  end
end
