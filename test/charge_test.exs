defmodule Stripe.ChargeTest do
  use ExUnit.Case, async: true

  alias Stripe.Charge
  alias Stripe.InvalidRequestError

  test "create a charge" do
    assert {:error, %InvalidRequestError{message: "Must provide source or customer."}}
      = Charge.create([])
  end

  test "retrieve a charge" do
    assert {:error, %InvalidRequestError{message: "No such charge: not exist"}}
      = Charge.retrieve("not exist")
  end

  test "list all charges" do
    assert {:ok, %{"object" => "list", "url" => "/v1/charges"}}
      = Charge.list
  end
end
