defmodule Stripex.Dispute do
  use Stripex.API, [:list, :create, :update]

  def endpoint do
    "disputes"
  end

  def close_dispute_endpoint(id) do
    "#{endpoint}/#{id}/close"
  end

  def close(id) do
    Stripex.request(:post, close_dispute_endpoint(id))
  end
end
