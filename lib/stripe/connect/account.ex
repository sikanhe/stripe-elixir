defmodule Stripe.Account do
  @moduledoc"""
  Functions related to connect accounts
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(account_id \\ "") do 
    "accounts/#{account_id}"
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
  def retrieve(account_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(account_id)
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
  def update(account_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(account_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(account_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(account_id)
    }
  end

  @spec reject(binary, Enum.t) :: Stripe.Request.t
  def reject(account_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(account_id)}/reject",
      params: params
    }
  end

  # external accounts

  @spec external_account_endpoint(binary) :: binary
  def external_account_endpoint(account_id, external_account_id \\ "") do 
    "#{endpoint(account_id)}/external_accounts/#{external_account_id}"
  end 

  @spec list_external_account(binary, Enum.t) :: Stripe.Request.t
  def list_external_account(account_id, pagination_opts \\ []) do
    %Stripe.Request{
      method: :get,
      endpoint: external_account_endpoint(account_id),
      params: pagination_opts
    }
  end

  @spec retrieve_external_account(binary, binary) :: Stripe.Request.t
  def retrieve_external_account(account_id, external_account_id) do
    %Stripe.Request{
      method: :get,
      endpoint: external_account_endpoint(account_id, external_account_id)
    }
  end

  @spec create_external_account(binary, Enum.t) :: Stripe.Request.t
  def create_external_account(account_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: external_account_endpoint(account_id),
      params: params
    }
  end

  @spec update_external_account(binary, binary, Enum.t) :: Stripe.Request.t
  def update_external_account(account_id, external_account_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: external_account_endpoint(account_id, external_account_id),
      params: params
    }
  end

  @spec delete_external_account(binary, binary) :: Stripe.Request.t
  def delete_external_account(account_id, external_account_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: external_account_endpoint(account_id, external_account_id)
    }
  end
end
