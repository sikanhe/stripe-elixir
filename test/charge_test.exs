defmodule Stripe.ChargeTest do
  use ExUnit.Case, async: true

  alias Stripe.Charge

  test "create a charge" do
    assert {:ok, %{"error" => %{"message" => "Must provide source or customer."}}}
      = Charge.create([])
  end

  test "retrieve a charge" do
    assert {:ok, %{"error" => %{"message" => "No such charge: not exist"}}}
      = Charge.retrieve("not exist")
  end

  test "list all charges" do
    assert {:ok, %{"object" => "list", "url" => "/v1/charges"}}
      = Charge.list
  end
end
