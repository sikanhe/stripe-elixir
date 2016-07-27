# Stripe

Stripe API client for Elixir. This lib closely follows the official Ruby Client API.
- Everything except for Relay features are complete and tested.
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
