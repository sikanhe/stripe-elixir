defmodule Stripex.EventTest do
  use ExUnit.Case, async: true

  alias Stripex.Event

  test "retrieve an event" do
    assert {:ok, %{"error" => %{"message" => "No such event: not exist"}}}
      = Event.retrieve("not exist")
  end

  test "list all events" do
    assert {:ok, %{"object" => "list", "url" => "/v1/events"}}
      = Event.list
  end
end
