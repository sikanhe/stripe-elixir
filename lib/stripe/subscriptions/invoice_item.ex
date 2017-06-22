defmodule Stripe.InvoiceItem do
  @moduledoc""" 
  Functions related to invoice items
  """

  @behavior Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(invoice_item_id \\ "") do
    "invoiceitems/#{invoice_item_id}"
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
  def retrieve(invoice_item_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(invoice_item_id)
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
  def update(invoice_item_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(invoice_item_id),
      params: params
    }
  end

  @spec delete(binary) :: Stripe.Request.t
  def delete(invoice_item_id) do
    %Stripe.Request{
      method: :delete,
      endpoint: endpoint(invoice_item_id)
    }
  end
end
