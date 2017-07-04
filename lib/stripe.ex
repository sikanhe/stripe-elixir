defmodule Stripe do
  @moduledoc """
  Main module for handling sending/receiving requests to Stripe's API
  """

  @default_api_endpoint "https://api.stripe.com/v1/"
  @client_version Mix.Project.config[:version]

  def version do
    @client_version
  end

  alias Stripe.{APIConnectionError,
                APIError,
                AuthenticationError,
                CardError,
                InvalidRequestError,
                RateLimitError}

  @missing_secret_key_error_message"""
    The secret_key settings is required to use stripe. Please include your
    stripe secret api key in your application config file like so:

      config :stripe, secret_key: YOUR_SECRET_KEY

    Alternatively, you can also set the secret key as an environment variable:

      STRIPE_SECRET_KEY=YOUR_SECRET_KEY
  """

  defp get_secret_key do
    System.get_env("STRIPE_SECRET_KEY") || 
    Application.get_env(:stripe, :secret_key) || 
    raise AuthenticationError, message: @missing_secret_key_error_message
  end

  defp get_api_endpoint do
    System.get_env("STRIPE_API_ENDPOINT") || 
    Application.get_env(:stripe, :api_endpoint) || 
    @default_api_endpoint
  end

  defp request_url(endpoint) do
    Path.join(get_api_endpoint(), endpoint)
  end

  defp request_url(endpoint, []) do
    Path.join(get_api_endpoint(), endpoint)
  end

  defp request_url(endpoint, data) do
    base_url = request_url(endpoint)
    query_params = Stripe.Utils.encode_data(data)
    "#{base_url}?#{query_params}"
  end

  defp create_headers(opts) do
    headers = 
      [{"Authorization", "Bearer #{get_secret_key()}"},
       {"User-Agent", "Stripe/v1 stripe-elixir/#{@client_version}"},
       {"Content-Type", "application/x-www-form-urlencoded"}]

    case Keyword.get(opts, :stripe_account) do 
      nil -> headers 
      account_id -> [{"Stripe-Account", account_id} | headers]
    end
  end

  def request(action, endpoint, data, opts) when action in [:get, :post, :delete] do
    HTTPoison.request(action, request_url(endpoint, data), "", create_headers(opts))
    |> handle_response
  end

  defp handle_response({:ok, %{body: body, status_code: 200}}) do
    {:ok, process_response_body(body)}
  end

  defp handle_response({:ok, %{body: body, status_code: code}}) do
    %{"message" => message} = error =
      body
      |> process_response_body
      |> Map.fetch!("error")

    error_struct =
      case code do
        code when code in [400, 404] ->
          %InvalidRequestError{message: message, param: error["param"]}
        401 ->
          %AuthenticationError{message: message}
        402 ->
          %CardError{message: message, code: error["code"], param: error["param"]}
        429 ->
          %RateLimitError{message: message}
        _ ->
          %APIError{message: message}
      end

    {:error, error_struct}
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    %APIConnectionError{message: "Network Error: #{reason}"}
  end

  defp process_response_body(body) do
    Poison.decode! body
  end
end
