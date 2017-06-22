defmodule Stripe.CountrySpec do
  @moduledoc"""
  Functions related to connect country specs.
  """

  @behaviour Stripe.API

  @spec endpoint(binary) :: binary
  def endpoint(country_spec_id) do
    "country_specs/#{country_spec_id}"
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
  def retrieve(country_spec_id) do
    %Stripe.Request{
      method: :get,
      endpoint: endpoint(country_spec_id)
    }
  end
end
