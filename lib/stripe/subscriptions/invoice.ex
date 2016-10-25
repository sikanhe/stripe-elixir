defmodule Stripe.Invoice do
  use Stripe.API, [:create, :retrieve, :update, :list]

  def endpoint do
    "invoices"
  end

  def line_items(%{"id" => invoice_id}) do
    line_items(invoice_id)
  end

  def line_items(invoice_id) do
    Stripe.request(:post, "#{endpoint}/#{invoice_id}/lines")
  end

  def upcoming(opts) do
    Stripe.request(:get, "#{endpoint}/upcoming", opts)
  end

  def pay(invoice_id) do
    Stripe.request(:post, "#{endpoint}/#{invoice_id}/pay")
  end
end
