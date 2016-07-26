defmodule Stripe.File do
  use Stripe.API, [:create, :retrieve, :list]

  def endpoint do
    "files"
  end
end
