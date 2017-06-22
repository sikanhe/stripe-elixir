defmodule Stripe.Token do
  @moduledoc"""
  Functions related to tokens
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(token_id \\ "") do 
    "tokens/#{token_id}"
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
  def retrieve(token_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(token_id)
    }
  end

  @spec create(Enum.t) :: Stripe.Request.t
  def create(params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(token_id),
      params: params
    }
  end
end
