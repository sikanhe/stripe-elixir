defmodule Stripe.InvoiceTest do
  use ExUnit.Case, async: true
  alias Stripe.{Customer, Invoice}

  test "create an invoice" do
    {:ok, customer} = Customer.create([])
    assert {:ok, %{"error" => %{"message" => "Nothing to invoice for customer"}}} =
      Invoice.create(customer: customer["id"])
  end
  #
  test "update/pay an invoice" do
    assert {:ok, %{"error" => %{"message" => "No such invoice: invoice_test"}}} =
      Invoice.retrieve("invoice_test")
  end

  test "update and invoice" do
    assert {:ok, %{"error" => %{"message" => "No such invoice: invoice_test"}}} =
      Invoice.update("invoice_test", metadata: [key: "value"])
  end

  test "pay an invoice" do
    assert {:ok, %{"error" => %{"message" => "No such invoice: invoice_test"}}} =
      Invoice.pay("invoice_test")
  end

  test "list all invoices" do
    assert {:ok, %{"object" => "list", "url" => "/v1/invoices"}} = Invoice.list
  end
end
