defmodule Stripe.Coupon do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "coupons"
  end
end
