defmodule Stripe.InvoiceTest do
  use ExUnit.Case, async: true
  alias Stripe.{Customer, Token, Invoice, InvoiceItem}

  setup_all do
    {:ok, customer} = Customer.create([])

    {:ok, card} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 7,
        exp_year: 2017,
        cvc: "111"
      ]
    )

    Customer.create_card(customer["id"], card["id"])

    {:ok, _invoice_item} = InvoiceItem.create(customer: customer["id"],
                                             amount: 100,
                                             currency: "usd",
                                             description: "invoice test")

    {:ok, invoice} = Invoice.create(customer: customer["id"])

    {:ok, invoice: invoice, customer: customer}
  end

  test "create an invoice", %{invoice: invoice} do
    assert %{"amount_due" => _} = invoice
  end
  #
  test "retrive an invoice", %{invoice: %{"id" => invoice_id}} do
    assert {:ok, %{"id" => ^invoice_id}} = Invoice.retrieve(invoice_id)
  end

  test "update an invoice", %{invoice: invoice} do
    assert {:ok, %{"metadata" => %{"key" => "value"}}} =
      Invoice.update(invoice["id"], metadata: [key: "value"])
  end

  test "pay an invoice", %{invoice: invoice} do
    assert {:ok, %{"paid" => true}} = Invoice.pay(invoice["id"])
  end

  test "list all invoices" do
    assert {:ok, %{"object" => "list", "url" => "/v1/invoices"}} = Invoice.list
  end

  test "retrieve upcoming invoices for a customer", %{customer: %{"id" => cus_id}} do
    assert {:error, %Stripe.InvalidRequestError{message: "No upcoming invoices for customer: " <> ^cus_id}} =
      Invoice.upcoming(customer: cus_id)
  end
end
