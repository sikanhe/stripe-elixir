defmodule Stripe do
  @moduledoc """
  Main module for handling sending/receiving requests to Stripe's API
  """

  @api "https://api.stripe.com/v1/"

  alias Stripe.{APIConnectionError,
                APIError,
                AuthenticationError,
                CardError,
                InvalidRequestError,
                RateLimitError}

  defmodule MissingSecretKeyError do
    defexception message: """
      The secret_key settings is required to use stripe. Please include your
      strip api key in your application config file like so:

        config :stripe, secret_key: YOUR_SECRET_KEY

      Alternatively, you can also set the secret key as an environment variable:

        STRIPE_SECRET_KEY=YOUR_SECRET_KEY
    """
  end

  defp get_stripe_key do
    Application.get_env(:stripe, :secret_key, System.get_env("STRIPE_SECRET_KEY"))
    || raise MissingSecretKeyError
  end

  defp request_url(endpoint) do
    Path.join(@api, endpoint)
  end

  defp request_url(endpoint, data) do
    base_url = request_url(endpoint)
    query_params = Stripe.Utils.encode_data(data)

    "#{base_url}?#{query_params}"
  end

  defp create_headers do
    app_version = Mix.Project.config[:version]
    bearer_token = get_stripe_key()

    [{"Authorization", "Bearer #{bearer_token}"},
     {"User-Agent", "Stripe/v1 stripe-elixir/#{app_version}"},
     {"Content-Type", "application/x-www-form-urlencoded"}]
  end

  def request(:delete, endpoint) do
    HTTPoison.delete(request_url(endpoint), create_headers())
    |> handle_response
  end

  def request(:post, endpoint) do
    HTTPoison.request(:post, request_url(endpoint), "", create_headers())
    |> handle_response
  end

  def request(:post, endpoint, data) do
    HTTPoison.request(:post, request_url(endpoint, data), "", create_headers())
    |> handle_response
  end

  def request(:get, endpoint, pagination_opts \\ []) do
    url = request_url(endpoint, pagination_opts)

    HTTPoison.get(url, create_headers())
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

  defp process_response_body(body) do
    Poison.decode! body
  end
end
