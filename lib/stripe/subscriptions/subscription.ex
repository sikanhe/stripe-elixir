defmodule Stripe.Subscription do
  @moduledoc"""
  Functions related to subscriptions
  """

  @behavior Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(subscription_id \\ "") do
    "subscriptions/#{subscription_id}"
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
  def retrieve(subscription_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(subscription_id)
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
  def update(subscription_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(subscription_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(subscription_id, options \\ []) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(subscription_id),
      params: options
    }
  end

  def delete_discount(subscription_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: "#{endpoint(subscription_id)}/discount"
    }
  end
end
