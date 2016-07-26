defmodule Stripex.Coupon do
  use Stripex.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "coupons"
  end
end
