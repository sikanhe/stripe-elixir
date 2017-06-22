defmodule Stripe.Request do 
  defstruct [
    method: nil,
    endpoint: nil,
    params: []
  ]

  @type t :: %{
    method: :get | :post | :delete,
    endpoint: binary,
    params: list() | map()
  }
end