defmodule Stripe.RateLimitError do
  @moduledoc """
  Too many requests hit the API too quickly.
  """
  defstruct type: "rate_limit_error", message: nil
end
