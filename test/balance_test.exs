defmodule Stripe.BalanceTest do
  use ExUnit.Case, async: true

  alias Stripe.Balance

  test "retrieve balance" do
    assert {:ok, %{"object" => "balance"}} = Balance.retrieve()
  end
end
