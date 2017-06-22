defmodule Stripe.API do
  @callback list(pagination_opts :: Enum.t) :: Stripe.Request.t
  @callback retrieve(id :: binary) :: Stripe.Request.t 
  @callback create(Enum.t) :: Stripe.Request.t
  @callback update(id :: binary, updates :: Enum.t) :: Stripe.Request.t 
  @callback delete(id :: binary, options :: Enum.t) :: Stripe.Request.t
  @optional_callbacks list: 1, retrieve: 1, create: 1, update: 2, delete: 2
end
