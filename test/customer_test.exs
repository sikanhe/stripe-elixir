defmodule Stripe.CustomerTest do
  use ExUnit.Case, async: true

  alias Stripe.{Customer, Token}
  alias Stripe.InvalidRequestError

  setup do
    assert {:ok, customer} = Customer.create([])

    {:ok, customer: customer}
  end

  test "create a customer", %{customer: customer} do
    assert %{"id" => _} = customer
  end

  test "retrieve a customer", %{customer: customer} do
    assert {:ok, ^customer} = Customer.retrieve(customer["id"])
  end

  test "update a customer", %{customer: customer} do
    assert {:ok, %{"email" => "hello@gmail.com"}} =
      Customer.update(customer["id"], email: "hello@gmail.com")
  end

  test "list all customers" do
    assert {:ok, %{"object" => "list", "url" => "/v1/customers"}}
      = Customer.list
  end

  test "add/update/delete a card to a customer", %{customer: customer} do
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

    assert {:ok, %{"name" => "new name"}} =
      Customer.update_card(customer["id"], card["id"], name: "new name")

    assert {:ok, %{"deleted" => true}} =
      Customer.delete_card(customer["id"], card["id"])
  end

  test "remove discount from customer", %{customer: customer} do
    assert {:error, %InvalidRequestError{message: "No active discount" <> _}} =
      Customer.delete_discount(customer["id"])
  end

  test "delete a customer", %{customer: customer} do
    assert {:ok, %{"deleted" => true}} = Customer.delete(customer["id"])
  end
end
