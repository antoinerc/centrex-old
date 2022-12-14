defmodule Centrex.ListingRegistry do
  def child_spec do
    Registry.child_spec(
      keys: :unique,
      name: __MODULE__,
      partitions: System.schedulers_online()
    )
  end

  def lookup_property(property_id) do
    key = find_address_key(property_id)

    case Registry.lookup(__MODULE__, key) do
      [{property_id, _}] -> {:ok, property_id}
      [] -> {:error, :not_found}
    end
  end

  defp find_address_key(address) do
    Registry.select(__MODULE__, [{{:"$1", :_, :_}, [], [:"$1"]}])
    |> Enum.find(&String.contains?(String.downcase(&1), address))
  end
end
