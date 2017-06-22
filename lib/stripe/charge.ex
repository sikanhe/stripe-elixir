defmodule Stripe.Charge do
  @moduledoc"""
  Functions related to charges
  """
  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(id \\ "") do
    "charges/#{id}"
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
  def retrieve(charge_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(charge_id)
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
  def update(charge_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(charge_id),
      params: params
    }
  end

  @spec capture(binary) :: Stripe.Request.t
  def capture(charge_id) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint()}/#{charge_id}/capture"
    }
  end
end
