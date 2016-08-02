defmodule Stripe.APIError do
  @moduledoc """
  API errors cover any other type of problem (e.g., a temporary problem with
  Stripe's servers) and are extremely uncommon.
  """
  defstruct type: "api_error", message: nil
end
