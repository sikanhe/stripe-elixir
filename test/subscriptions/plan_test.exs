defmodule Stripe.PlanTest do
  use ExUnit.Case, async: true
  alias Stripe.Plan

  test "create/update/delete a plan" do
    Plan.delete("plan_test")
    assert {:ok, plan} = Plan.create(name: "plan_test",
                                     id: "plan_test",
                                     amount: 1,
                                     currency: "usd",
                                     interval: "month")

    assert {:ok, ^plan} = Plan.retrieve("plan_test")
    assert {:ok, %{"name" => "premium"}} = Plan.update("plan_test", name: "premium")
    assert {:ok, %{"deleted" => true}} = Plan.delete("plan_test")
    assert {:ok, %{"error" => %{"message" => "No such plan: plan_test"}}} =
      Plan.retrieve("plan_test")
  end

  test "list all plans" do
    assert {:ok, %{"object" => "list", "url" => "/v1/plans"}} = Plan.list
  end
end
