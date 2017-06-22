defmodule Stripe.SignatureVerificationError do
  @moduledoc """
  Failure to verify payload with signature attached to webhook requests.
  """
  defexception type: "signature_verification_error", message: nil
end
