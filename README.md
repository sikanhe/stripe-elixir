# Stripe

Stripe API client for Elixir.
- Everything except for Relay features are complete and tested.
- Currently working on client connection retry logic/network error handling.
- Looking for more contributors/maintainers for this project, currently need help with documentation.

## Installation

  1. Add `stripe` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:stripe, "~> 0.1.0"}]
    end
    ```

  2. Ensure `stripe` is started before your application:

    ```elixir
    def application do
      [applications: [:stripe]]
    end
    ```

  3. Make sure your stripe secret_key is added to your config file:

    ```elixir
    config :stripe, secret_key: YOUR_SECRET_KEY
    ```

  4. Alternatively, you can also set the secret key as an environment variable:

    ```elixir
    STRIPE_SECRET_KEY=YOUR_SECRET_KEY
    ```

## Basic Usage

This lib closely follows the official Ruby Client API.

`Stripe.{RESOURCE}.create`
`Stripe.{RESOURCE}.retrieve`
`Stripe.{RESOURCE}.update`
`Stripe.{RESOURCE}.list`

Returns {:ok, RESPONSE_BODY} when the request is successful.

{:error, _} tuples are only returned when there is a network error
