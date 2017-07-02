defmodule Stripe.Customer do
  @moduledoc"""
  Functions related to a customer
  """
  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(id \\ "") do
    "/customers/#{id}"
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
  def retrieve(customer_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(customer_id)
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
  def update(customer_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(customer_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(customer_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(customer_id)
    }
  end

  # discount

  @spec delete_discount(binary) :: Stripe.Request.t
  def delete_discount(customer_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: "#{endpoint(customer_id)}/discount"
    }
  end 

  # sources

  @spec list_sources(binary, Enum.t) :: Stripe.Request.t 
  def list_sources(customer_id, pagination_opts \\ []) do 
    %Stripe.Request{
      method: :get,
      endpoint: "#{endpoint(customer_id)}/sources",
      params: pagination_opts
    }
  end

  @spec retrieve_source(binary, binary) :: Stripe.Request.t 
  def retrieve_source(customer_id, source_id) do 
    %Stripe.request{
      method: :get,
      endpoint: "#{endpoint(customer_id)}/sources/#{source_id}"
    }
  end

  @spec create_source(binary, params) :: Stripe.Request.t
  def create_source(customer_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(customer_id)}/sources",
      params: params
    }
  end

  @spec update_source(binary, binary, params) :: Stripe.Request.t
  def update_source(customer_id, source_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(customer_id)}/sources/#{source_id}",
      params: params
    }
  end

  @spec delete_source(binary, binary) :: Stripe.Request.t
  def delete_source(customer_id, source_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: "#{endpoint(customer_id)}/sources/#{source_id}"
    }
  end

  @spec list_cards(binary, Enum.t) :: Stripe.Request.t
  def list_cards(customer_id, pagination_opts \\ []) do
    list_sources(customer_id, pagination_opts)
    |> put_in([:params, :object], "card")
  end

  @spec create_card(customer_id, card_id) :: Stripe.Request.t 
  def create_card(customer_id, card_id) do
    create_source(customer_id, [source: card_id])
  end

  @spec update_card(binary, binary, Enum.t) :: Stripe.Request.t
  def update_card(customer_id, card_id, updates) do
    update_source(customer_id, card_id, updates)
  end

  @doc """ 
  Verify a bank account using two small deposit amounts (in cents). 

      Stripe.Customer.verify_bank_account("cus_DKdfmidqL", "bank_dWIKSdlwi", [19, 29])
      |> Stripe.request!
  """
  @spec verify_bank_account(binary, binary, list :: Stripe.Request.t
  def verify_bank_account(customer_id, bank_acct_id, amounts) do 
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(customer_id)}/sources/#{bank_acct_id}/verify",
      params: [amounts: amounts]
    }

  @spec list_bank_accounts(binary, binary) :: Stripe.Request.t
  def list_bank_accounts(customer_id, pagination_opts \\ []) do
    list_sources(customer_id, pagination_opts)
    |> put_in([:params, :object], "bank_account")
  end
end
