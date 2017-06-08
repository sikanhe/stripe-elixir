defmodule Stripe.Charge do
  use Stripe.API, [:list, :retrieve, :create, :update]

  def endpoint do
    "charges"
  end

  def capture_endpoint(id) do
    "#{endpoint()}/#{id}/capture"
  end

  def capture(id, opts \\ []) do
    Stripe.request(:post, capture_endpoint(id), [], opts)
  end
end
