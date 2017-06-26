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

  test "list cards", %{customer: customer} do
    {:ok, token} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 8,
        exp_year: 2019,
        cvc: "143"
      ]
    )

    assert {:ok, %{"id" => _source_id, "object" => "card"}} =
      Customer.create_card(customer["id"], token["id"])

    customer_sources_url = "/v1/customers/#{customer["id"]}/sources"

    assert {:ok, %{"data" => data,
                   "object" => "list",
                   "url" => ^customer_sources_url}} =
      Customer.list_cards(customer["id"])

    assert length(data) > 0
  end

  test "add/update/delete a card to a customer", %{customer: customer} do
    {:ok, token} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 7,
        exp_year: 2017,
        cvc: "314"
      ]
    )

    assert {:ok, %{"id" => source_id, "object" => "card"}} =
      Customer.create_card(customer["id"], token["id"])

    assert {:ok, %{"name" => "new name"}} =
      Customer.update_card(customer["id"], source_id, name: "new name")

    assert {:ok, %{"deleted" => true}} =
      Customer.delete_card(customer["id"], source_id)
  end

  test "remove discount from customer", %{customer: customer} do
    assert {:error, %InvalidRequestError{message: "No active discount" <> _}} =
      Customer.delete_discount(customer["id"])
  end

  test "delete a customer", %{customer: customer} do
    assert {:ok, %{"deleted" => true}} = Customer.delete(customer["id"])
  end

  test "create and verify a bank account", %{customer: customer} do
    {:ok, %{"id" => token}} = Token.create(
      bank_account: %{
        account_number: "000123456789",
        routing_number: "110000000",
        country: "US",
        currency: "usd",
        account_holder_name: "Sikan He",
        account_holder_type: "individual"
      }
    )
    {:ok, %{"id" => source_id}} = Customer.create_source(customer["id"], source: token)
    {:ok, %{"status" => "verified"}} = Customer.verify_bank_account(customer["id"], source_id, [32, 45])
  end

  test "list bank accounts", %{customer: customer} do
    {:ok, %{"id" => token}} = Token.create(
      bank_account: %{
        account_number: "000123456789",
        routing_number: "110000000",
        country: "US",
        currency: "usd",
        account_holder_name: "Sikan He",
        account_holder_type: "individual"
      }
    )

    {:ok, %{"id" => _source_id}} = Customer.create_source(customer["id"], source: token)

    customer_sources_url = "/v1/customers/#{customer["id"]}/sources"

    assert {:ok, %{"data" => data,
                   "object" => "list",
                   "url" => ^customer_sources_url}} =
      Customer.list_bank_accounts(customer["id"])

    assert length(data) > 0
  end

end
