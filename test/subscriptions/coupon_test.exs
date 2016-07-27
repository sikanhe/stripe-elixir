defmodule Stripe.CouponTest do
  use ExUnit.Case, async: true
  alias Stripe.Coupon

  test "create/update/delete a coupon" do
    Coupon.delete("COUPONTEST")
    assert {:ok, coupon} = Coupon.create(id: "COUPONTEST",
                                         duration: "forever",
                                         percent_off: 50)

    assert {:ok, ^coupon} = Coupon.retrieve(coupon["id"])
    assert {:ok, %{"metadata" => %{"key" => "value"}}} =
      Coupon.update(coupon["id"], metadata: [key: "value"])
    assert {:ok, %{"deleted" => true}} = Coupon.delete(coupon["id"])
  end

  test "list all coupons" do
    assert {:ok, %{"object" => "list"}} = Coupon.list
  end
end
