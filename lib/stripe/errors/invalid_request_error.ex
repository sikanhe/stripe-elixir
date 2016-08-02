defmodule Stripe.InvalidRequestError do
  @moduledoc """
  Invalid request errors arise when your request has invalid parameters.
  """
  defstruct type: "invalid_request_error", message: nil, param: nil
end
