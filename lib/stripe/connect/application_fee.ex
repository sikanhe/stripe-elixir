defmodule Stripe.ApplicationFee do
  use Stripe.API, [:create, :retrieve, :update, :list]

  def endpoint do
    "application_fees"
  end

  def refund(fee_id) do
    Stripe.request(:post, "#{endpoint()}/#{fee_id}/refund")
  end

  def retrieve_refund(fee_id, refund_id) do
    Stripe.request(:get, "#{endpoint()}/#{fee_id}/refund/#{refund_id}")
  end
end
