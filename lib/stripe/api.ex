defmodule Stripe.API do
  defmacro __using__(opts) do
    quote do
      if :create in unquote(opts) do
        @doc """
        Create a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def create(data, opts \\ []) do
          Stripe.request(:post, endpoint(), data, opts)
        end
      end

      if :retrieve in unquote(opts) do
        @doc """
        Retrive a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last} by its ID
        """
        def retrieve(id, opts \\ []) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Stripe.request(:get, resource_url, [], opts)
        end
      end

      if :update in unquote(opts) do
        @doc """
        Update a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def update(id, data, opts \\ []) do
          resource_url = Path.join(endpoint(), id)
          Stripe.request(:post, resource_url, data, opts)
        end
      end

      if :list in unquote(opts) do
        @doc """
        List all #{__MODULE__ |> to_string |> String.split(".") |> List.last}s
        """
        def list(pagination_opts \\ [], opts \\ []) when is_list(pagination_opts) do
          Stripe.request(:get, endpoint(), pagination_opts, opts)
        end
      end

      if :delete in unquote(opts) do
        @doc """
        Delete a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def delete(id, data \\ [], opts \\ []) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Stripe.request(:delete, resource_url, data, opts)
        end
      end
    end
  end
end
