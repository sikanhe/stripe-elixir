defmodule Stripe.PlanTest do
  use ExUnit.Case, async: true
  alias Stripe.Plan

  test "create/update/delete a plan" do
    assert {:ok, plan} = Plan.create(name: "basic",
                                     id: "basic",
                                     amount: 1,
                                     currency: "usd",
                                     interval: "month")

    assert {:ok, ^plan} = Plan.retrieve(plan["id"])
    assert {:ok, %{"name" => "premium"}} = Plan.update(plan["id"], name: "premium")
    assert {:ok, %{"deleted" => true}} = Plan.delete(plan["id"])
    assert {:ok, %{"error" => %{"message" => "No such plan: basic"}}} =
      Plan.retrieve(plan["id"])
  end

  test "list all plans" do
    assert {:ok, %{"object" => "list", "url" => "/v1/plans"}} = Plan.list
  end
end
