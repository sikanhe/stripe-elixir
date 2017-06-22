defmodule Stripe.Connect do 
  @moduledoc"""
  Functions related to Connect
  """

  @oauth_url "https://connect.stripe.com/oauth/authorize"

  @spec authorize_url(Keyword.t) :: binary
  def authorize_url(opts \\ []) do 
    query_params = 
      opts 
      |> Keyword.put_new(:client_id, get_client_id())
      |> Keyword.put_new(:scope, "read_write")
      |> Keyword.put_new(:response_type, "code")
      |> Stripe.Utils.encode_data()

    @oauth_url <> "?" <> query_params
  end

  @missing_client_id_error_message """
    A Connect Client ID is required to use stripe. Please include your
    connect Client ID in your application config file like so:

      config :stripe, client_id: <YOUR_CLIENT_ID>

    Alternatively, you can also set the secret key as an environment variable:

      STRIPE_CLIENT_ID=<YOUR_CLIENT_ID>

    You can also pass in client_id option for Stripe.Connect.generate_authorize_url/1
      Stripe.Connect.generate_authorize_url(client_id: <YOUR_CLIENT_ID>)
  """

  defp get_client_id do 
    System.get_env(:STRIPE_CLIENT_ID) || 
    Application.get_env(:stripe, :client_id) || 
    raise Stripe.AuthenticationError, message: @missing_client_id_error_message
  end
end