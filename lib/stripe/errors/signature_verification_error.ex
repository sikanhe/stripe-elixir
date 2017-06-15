defmodule Stripe.SignatureVerificationError do
  @moduledoc """
  Failure to verify payload with signature attached to webhook requests.
  """
  defstruct type: "signature_verification_error", message: nil
end
