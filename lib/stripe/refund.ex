defmodule Stripe.Refund do
  @moduledoc""" 
  Functions related to refunds.
  """

  @behavior Stripe.API
  
  @spec endpoint(binary) :: binary
  def endpoint(refund_id \\ "") do
    "refunds/#{refund_id}"
  end

  @spec list(Enum.t) :: Stripe.Request.t
  def list(pagination_opts \\ []) do 
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(),
      params: pagination_opts
    }
  end
  
  @spec retrieve(binary) :: Stripe.Request.t
  def retrieve(refund_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(refund_id)
    }
  end

  @spec create(Enum.t) :: Stripe.Request.t
  def create(params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(),
      params: params
    }
  end

  @spec update(binary, Enum.t) :: Stripe.Request.t
  def update(refund_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(refund_id),
      params: params
    }
  end
end
