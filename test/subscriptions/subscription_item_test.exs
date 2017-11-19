defmodule Stripe.SubscriptionItemTest do
  use ExUnit.Case, async: true
  alias Stripe.{Subscription, SubscriptionItem, Plan, Customer, Token}
  alias Stripe.InvalidRequestError
  alias Stripe.Fixture.Token, as: TokenFixture

  @addon_id "addon_plan"

  setup do
    {:ok, customer} = Customer.create([])

    {:ok, card} = TokenFixture.valid_card() |> Token.create()

    Customer.create_card(customer["id"], card["id"])

    Plan.delete(@addon_id)
    Plan.delete("sub_item_test_plan")
    {:ok, plan} = Plan.create(name: "sub_item_test_plan",
      id: "sub_item_test_plan",
      amount: 999,
      currency: "usd",
      interval: "month")

    {:ok, _addon_plan} = Plan.create(name: "addon_plan",
      id: @addon_id,
      amount: 1,
      currency: "usd",
      interval: "month")

    {:ok, subscription} = Subscription.create(customer: customer["id"],
      plan: plan["id"])

    {:ok, subscription: subscription}
  end

  test "create/update/delete a subscription_item", %{subscription: subscription} do
    SubscriptionItem.delete("subscription_item_test")
    assert {:ok, subscription_item} = SubscriptionItem.create(subscription: subscription["id"],
      plan: @addon_id,
      quantity: 1)

    assert {:ok, ^subscription_item} = SubscriptionItem.retrieve(subscription_item["id"])
    assert {:ok, %{"quantity" => 2}} = SubscriptionItem.update(subscription_item["id"], quantity: 2)
    assert {:ok, %{"deleted" => true}} = SubscriptionItem.delete(subscription_item["id"])
    assert {:error, %InvalidRequestError{message: "Invalid subscription_item id" <> _}} =
      SubscriptionItem.retrieve(subscription_item["id"])
  end

  test "list all subscription_items", %{subscription: subscription} do
    assert {:ok, %{"data" => list}} = SubscriptionItem.list(subscription: subscription["id"])
    assert length(list) > 0
  end
end
