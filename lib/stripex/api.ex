defmodule Stripex.API do
  defmacro __using__(opts) do
    quote do
      if :create in unquote(opts) do
        def create(form) do
          Stripex.request(:post, endpoint(), form)
        end
      end

      if :retrieve in unquote(opts) do
        def retrieve(id) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Stripex.request(:get, resource_url)
        end
      end

      if :update in unquote(opts) do
        def update(id, updates) do
          resource_url = Path.join(endpoint(), id)
          Stripex.request(:post, resource_url, updates)
        end
      end

      if :list in unquote(opts) do
        def list(pagination_opts \\ []) when is_list(pagination_opts) do
          Stripex.request(:get, endpoint(), pagination_opts)
        end
      end

      if :delete in unquote(opts) do
        def delete(id) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Stripex.request(:delete, resource_url)
        end
      end
    end
  end
end
