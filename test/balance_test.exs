defmodule Stripex.BalanceTest do
  use ExUnit.Case, async: true

  alias Stripex.Balance

  test "retrieve balance" do
    assert {:ok, %{"object" => "balance"}} = Balance.retrieve()
  end
end
