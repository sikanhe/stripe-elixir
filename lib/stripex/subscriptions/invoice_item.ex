defmodule Stripex.InvoiceItem do
  use Stripex.API, [:create, :retrieve, :update, :delete, :list]

  def endpoint do
    "invoiceitems"
  end
end
