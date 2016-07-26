defmodule Stripex.TokenTest do
  use ExUnit.Case, async: true

  alias Stripex.Token

  test "create a token" do
    assert {:ok, token} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 7,
        exp_year: 2017,
        cvc: "314"
      ]
    )

    assert {:ok, ^token} = Token.retrieve(token["id"])
  end

  test "retrieve a token" do
    assert {:ok, %{"error" => %{"message" => "No such token: not exist"}}}
      = Token.retrieve("not exist")
  end
end
