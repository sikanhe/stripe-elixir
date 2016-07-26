defmodule Stripex.Charge do
  use Stripex.API, [:list, :retrieve, :create, :update]

  def endpoint do
    "charges"
  end

  def capture_endpoint(id) do
    "#{endpoint}/#{id}/capture"
  end

  def capture(id) do
    Stripex.request(:post, capture_endpoint(id))
  end
end
