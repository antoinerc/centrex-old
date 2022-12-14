defmodule Centrex.Listings.ListingProcess do
  use GenServer, restart: :transient

  alias Centrex.Listings.Listing
  alias Centrex.ListingRegistry

  def start_link(%Listing{} = listing) do
    GenServer.start_link(__MODULE__, listing,
      name: {:via, Registry, {Centrex.ListingRegistry, listing.address}}
    )
  end

  @spec read(String.t()) :: Listing.t() | {:error, atom()}
  def read(address) do
    address
    |> ListingRegistry.lookup_property()
    |> case do
      {:ok, pid} -> GenServer.call(pid, :read)
      error -> error
    end
  end

  @impl true
  def init(%Listing{} = state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:read, _from, %Listing{} = state) do
    {:reply, state, state}
  end
end
