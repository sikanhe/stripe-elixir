defmodule Stripex.CustomerTest do
  use ExUnit.Case, async: true

  alias Stripex.{Customer, Token}

  test "create, retrieve and delete a customer" do
    assert {:ok, customer} = Customer.create([])
    assert {:ok, ^customer} = Customer.retrieve(customer["id"])
    assert {:ok, %{"deleted" => true}} = Customer.delete(customer["id"])
  end

  test "list all customers" do
    assert {:ok, %{"object" => "list", "url" => "/v1/customers"}}
      = Customer.list
  end

  test "add/delete a card to a customer" do
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

    assert {:ok, %{"deleted" => true}} =
      Customer.delete_card(customer["id"], card["id"])

    assert {:ok, %{"sources" => %{"data" => []}}} =
      Customer.retrieve(customer["id"])
  end
end
