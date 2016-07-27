defmodule Stripe.SubscriptionTest do
  use ExUnit.Case, async: true
  alias Stripe.{Subscription, Plan, Customer, Token}

  test "create/update/delete a subscription" do
    {:ok, customer} = Customer.create([])

    {:ok, card} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 7,
        exp_year: 2017,
        cvc: "314"
      ]
    )

    assert {:ok, %{"sources" => %{"data" => [card]}}} =
      Customer.create_card(customer["id"], card["id"])

    Plan.delete("sub_test_plan")
    {:ok, plan} = Plan.create(name: "sub_test_plan",
                              id: "sub_test_plan",
                              amount: 999,
                              currency: "usd",
                              interval: "month")

    assert {:ok, subscription} = Subscription.create(customer: customer["id"],
                                              plan: plan["id"])

    assert {:ok, ^subscription} = Subscription.retrieve(subscription["id"])

    assert {:ok, %{"metadata" => %{"key" => "value"}}} =
      Subscription.update(subscription["id"], metadata: [key: "value"])

    assert {:ok, %{"status" => "canceled"}} = Subscription.delete(subscription["id"])
  end

  test "list all subscriptions" do
    assert {:ok, %{"object" => "list", "url" => "/v1/subscriptions"}} = Subscription.list
  end
end
