defmodule Stripe.Coupon do
  @moduledoc"""
  Functions related to coupons
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(coupon_id) do
    "coupons/#{coupon_id}"
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
  def retrieve(coupon_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(coupon_id)
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
  def update(coupon_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(coupon_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(coupon_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(coupon_id)
    }
  end
end
