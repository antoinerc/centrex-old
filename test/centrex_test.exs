defmodule CentrexTest do
  use ExUnit.Case, async: true
  doctest Centrex

  setup do
    registry = start_supervised!(Centrex.Registry)
    %{registry: registry}
  end

  test "greets the world" do
    assert Centrex.hello() == :world
  end

  test "spawns buckets", %{registry: registry} do
    assert Centrex.Registry.lookup(registry, "condos") == :error

    Centrex.Registry.create(registry, "condos")
    assert {:ok, bucket} = Centrex.Registry.lookup(registry, "condos")

    Centrex.Registry.put(bucket, 10_676_368, %{
      address: "115, Route 225, Wotton",
      price_history: [100, 200],
      link: "https://test.com"
    })

    assert Centrex.Registry.get(bucket, 10_676_368) == %{
             address: "115, Route 225, Wotton",
             price_history: [100, 200],
             link: "https://test.com"
           }
  end
end
