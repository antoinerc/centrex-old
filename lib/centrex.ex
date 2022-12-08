defmodule Centrex do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [Centrex.ListingRegistry.child_spec(), Centrex.ListingSupervisor, Centrex.Repo]
    opts = [strategy: :one_for_one, name: Centrex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
