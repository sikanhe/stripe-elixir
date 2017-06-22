defmodule Stripe.Transfer do
  @moduledoc""" 
  Functions related to transfers.
  """

  @behavior Stripe.API

  @spec endpoint(binary) :: binary 
  def endpoint(transfer_id \\ "") do
    "transfers/#{transfer_id}"
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
  def retrieve(transfer_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(transfer_id)
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
  def update(transfer_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(transfer_id),
      params: params
    }
  end

  @spec reversal_endpoint(binary, binary) :: binary
  def reversal_endpoint(transfer_id, reversal_id \\ "") do
    "#{endpoint(transfer_id)}/reversals/#{reversal_id}"
  end

  @spec list_reversals(binary, Enum.t) :: Stripe.Request.t
  def list_reversals(transfer_id, pagination_opts \\ []) do
    %Stripe.Request{
      method: :get,
      endpoint: reversal_endpoint(),
      params: pagination_opts
    }
  end

  @spec create_reversals(binary, Enum.t) :: Stripe.Request.t
  def create_reversal(transfer_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: reversal_endpoint(),
      params: params
    }
  end
  
  @spec retrieve_reversals(binary, binary) :: Stripe.Request.t
  def retrieve_reversal(transfer_id, reversal_id) do
    %Stripe.Request{
      method: :get,
      endpoint: reversal_endpoint(transfer_id, reversal_id)
    }
  end

  @spec update_reversal(binary, binary, Enum.t) :: Stripe.Request.t
  def update_reversal(transfer_id, reversal_id, params) do
    %Stripe.Request{
      method: :get,
      endpoint: reversal_endpoint(transfer_id, reversal_id),
      params: params
    }
  end
end
