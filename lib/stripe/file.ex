defmodule Stripe.File do
  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(file_id \\ "") do
    "files/#{file_id}"
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
  def retrieve(file_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(file_id)
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
end
