defmodule Stripe.Recipient do
  @moduledoc"""
  Functions related to recipents
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(recipient_id \\ "") do
    "recipients/#{recipient_id}"
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
  def retrieve(recipient_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(recipient_id)
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
  def update(recipient_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(recipient_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(recipient_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(recipient_id)
    }
  end
end
