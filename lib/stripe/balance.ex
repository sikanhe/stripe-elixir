defmodule Stripe.Balance do
  @moduledoc""" 
  Functions related to get balance information
  """

  @behaviour Stripe.API

  @spec endpoint :: binary
  def endpoint do
    "balance"
  end

  @spec retrieve() :: Stripe.Request.t
  def retrieve do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint()
    }
  end
end
