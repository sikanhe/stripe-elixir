defmodule Stripe.Error do
  defstruct [:type, :message, :code, :param]
end
