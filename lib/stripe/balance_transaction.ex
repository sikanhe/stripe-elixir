defmodule Stripe.BalanceTransaction do
  @moduledoc"""
  Functions related for balance history
  """

  @behavior Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(id \\ "") do
    "balance/history/#{id}"
  end

  @spec retrieve(binary) :: Stripe.Request.t
  def retrieve(balance_id) do 
    %Stripe.Request{
      method: :get, 
      endpoint: endpoint(balance_id)
    }
  end

  @spec all(Enum.t) :: Stripe.Request.t
  def all(pagination_opts \\ []) do 
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(),
      params: pagination_opts
    }
  end
end
