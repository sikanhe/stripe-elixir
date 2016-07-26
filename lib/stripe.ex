defmodule Stripe do
  @api "https://api.stripe.com/v1/"

  defmodule MissingSecretKeyError do
    defexception message: """
      The secret_key settings is required to use stripe. Please include your
      strip api key in your application config file like so:

        config :stripe, secret_key: YOUR_SECRET_KEY

      Alternatively, you can also set the secret key as an environment variable:

        STRIPE_SECRET_KEY=YOUR_SECRET_KEY
    """
  end

  def get_stripe_key do
    Application.get_env(:stripe, :secret_key, System.get_env("STRIPE_SECRET_KEY"))
    || raise MissingSecretKeyError
  end

  def request_url(endpoint) do
    Path.join(@api, endpoint)
  end

  def request_url(endpoint, data) do
    base_url = request_url(endpoint)
    query_params = Stripe.Utils.encode_data(data)

    "#{base_url}?#{query_params}"
  end

  def create_headers do
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

  def handle_response({:ok, %{body: body}}) do
    {:ok, process_response_body(body)}
  end

  def process_response_body(body) do
    Poison.decode! body
  end
end
