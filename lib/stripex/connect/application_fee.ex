defmodule Stripex.ApplicationFee do
  use Stripex.API, [:create, :retrieve, :update, :list]

  def endpoint do
    "application_fees"
  end

  def refund(fee_id) do
    Stripex.request(:post, "#{endpoint}/#{fee_id}/refund")
  end

  def retrieve_refund(fee_id, refund_id) do
    Stripex.request(:get, "#{endpoint}/#{fee_id}/refund/#{refund_id}")
  end
end
