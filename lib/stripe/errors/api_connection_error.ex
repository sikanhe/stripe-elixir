defmodule Stripe.APIConnectionError do
  @moduledoc """
  Failure to connect to Stripe's API.
  """
  defexception type: "api_connection_error", message: nil
end
