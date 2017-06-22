defmodule Stripe.ApplicationFee do
  @behavior Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(application_fee_id \\ "") do
    "application_fees/#{application_fee_id}"
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
  def retrieve(application_fee_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(application_fee_id)
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
  def update(application_fee_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(application_fee_id),
      params: params
    }
  end

  # refunds

  def refund(fee_id) do
    %Stripe.Request{
      method: :post,
      endpint: "#{endpoint(fee_id)}/refund"
    }
  end

  def retrieve_refund(fee_id, refund_id, opts \\ []) do
    %Stripe.Request{
      method: :get,
      endpint: "#{endpoint(fee_id)}/refund/#{refund_id}"
    }
  end
end
