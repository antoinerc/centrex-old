defmodule Centrex.ListingRegistry do
  def child_spec do
    Registry.child_spec(
      keys: :unique,
      name: __MODULE__,
      partitions: System.schedulers_online()
    )
  end

  def lookup_property(property_id) do
    case Registry.lookup(__MODULE__, property_id) do
      [{property_id, _}] -> {:ok, property_id}
      [] -> {:error, :not_found}
    end
  end
end
