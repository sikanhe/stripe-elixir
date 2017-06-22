defmodule Stripe.CardError do
  @moduledoc """
  Card errors are the most common type of error you should expect to handle.
  They result when the user enters a card that can't be charged for some reason.
  """
  defexception type: "card_error", message: nil, param: nil, code: nil
end
