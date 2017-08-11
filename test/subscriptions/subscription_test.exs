defmodule Stripe.SubscriptionTest do
  use ExUnit.Case, async: true
  import Stripe.Fixture.Token
  alias Stripe.{Subscription, Plan, Customer, Token}
  alias Stripe.InvalidRequestError

  setup do
    {:ok, customer} = Customer.create([])

    {:ok, card} = valid_card() |> Token.create()

    Customer.create_card(customer["id"], card["id"])

    Plan.delete("sub_test_plan")
    {:ok, plan} = Plan.create(name: "sub_test_plan",
                              id: "sub_test_plan",
                              amount: 999,
                              currency: "usd",
                              interval: "month")

    {:ok, subscription} = Subscription.create(customer: customer["id"],
                                              plan: plan["id"])

    on_exit fn ->
      Plan.delete("sub_test_plan")
    end

    {:ok, subscription: subscription}
  end

  test "delete discount for a subscription", %{subscription: subscription} do
    assert {:error, %InvalidRequestError{message: "No active discount for subscription" <> _}} =
      Subscription.delete_discount(subscription["id"])
  end

  test "create/update/delete a subscription", %{subscription: subscription} do
    assert {:ok, ^subscription} = Subscription.retrieve(subscription["id"])

    assert {:ok, %{"metadata" => %{"key" => "value"}}} =
      Subscription.update(subscription["id"], metadata: [key: "value"])

    assert {:ok, %{"status" => "active", "cancel_at_period_end" => true}} =
      Subscription.delete(subscription["id"], at_period_end: true)
  end

  test "list all subscriptions" do
    assert {:ok, %{"object" => "list", "url" => "/v1/subscriptions"}} = Subscription.list
  end
end
