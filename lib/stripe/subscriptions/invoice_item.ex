defmodule Stripe.InvoiceItem do
  use Stripe.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "invoiceitems"
  end
end
