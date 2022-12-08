defmodule CentrexServer do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def insert(pid, element) do
    GenServer.cast(pid, {:insert, element})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:insert, %{price_history: _}} = element, state) do
    {:noreply, [element | state]}
  end
end
