defmodule Stripe.TransferTest do
  use ExUnit.Case, async: true
  alias Stripe.Transfer
  alias Stripe.InvalidRequestError

  test "create a transfer" do
    assert {:error, %InvalidRequestError{param: "destination"}} = Transfer.create(amount: 100,
                                             currency: "usd",
                                             destination: "transfer_test")
  end

  test "retrieve a transfer" do
    assert {:error, %InvalidRequestError{message: "No such transfer: test"}} =
      Transfer.retrieve("test")
  end

  test "update a transfer" do
    assert {:error, %InvalidRequestError{message: "No such transfer: test"}} =
      Transfer.update("test", metadata: [key: "value"])
  end

  test "list all transfers" do
    assert {:ok, %{"object" => "list", "url" => "/v1/transfers"}} = Transfer.list
  end
end
