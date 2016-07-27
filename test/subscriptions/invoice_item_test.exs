defmodule Stripe.InvoiceItemTest do
  use ExUnit.Case
  alias Stripe.{Customer, InvoiceItem}

  setup do
    {:ok, customer} = Customer.create([])

    {:ok, invoice_item} = InvoiceItem.create(customer: customer["id"],
                                             amount: 100,
                                             currency: "usd",
                                             description: "invoice item test")

    {:ok, invoice_item: invoice_item}
  end

  test "create invoice item", %{invoice_item: invoice_item} do
    assert %{"object" => "invoiceitem"} = invoice_item
  end

  test "update invoice item", %{invoice_item: invoice_item} do
    assert {:ok, %{"amount" => 99}} = InvoiceItem.update(invoice_item["id"],
                                                         amount: 99)
  end

  test "retrieve an invoice item", %{invoice_item: invoice_item} do
    assert {:ok, ^invoice_item} = InvoiceItem.retrieve(invoice_item["id"])
  end

  test "delete an invoice item", %{invoice_item: invoice_item} do
    assert {:ok, %{"deleted" => true}} = InvoiceItem.delete(invoice_item["id"])
  end
end
