defmodule Stripe.Event do
  @moduledoc"""
  Functions related to events
  """

  @behavior Stripe.API

  @spec endpoint(binary, binary) :: Stripe.Request.t
  def endpoint(event_id \\ "") do
    "events/#{event_id}"
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
  def retrieve(event_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(event_id)
    }
  end
end
