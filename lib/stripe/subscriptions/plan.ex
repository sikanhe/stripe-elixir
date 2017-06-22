defmodule Stripe.Plan do
  @moduledoc"""
  Functions related to subscription plans.
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(plan_id) do
    "plans/#{plan_id}"
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
  def retrieve(plan_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(plan_id)
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
  def update(plan_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(plan_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(plan_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(plan_id)
    }
  end
end
