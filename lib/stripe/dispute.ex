defmodule Stripe.Dispute do
  @behavior Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(dispute_id \\ "") do
    "disputes/#{dispute_id}"
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
  def retrieve(dispute_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(dispute_id)
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
  def update(dispute_id, params) do
    %Stripe.Request{
      method: :post,
      endpoint: endpoint(dispute_id),
      params: params
    }
  end

  def close(dispute_id) do
    %Stripe.Request{
      method: :post,
      endpoint: "#{endpoint(dispute_id)}/close"
    }
  end
end
