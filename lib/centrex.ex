defmodule Centrex do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # TODO: Maybe move DiscordConsumer into its own supervisor
    children = [
      Centrex.ListingRegistry.child_spec(),
      Centrex.ListingSupervisor,
      Centrex.Repo,
      Centrex.DiscordConsumer
    ]

    opts = [strategy: :one_for_one, name: Centrex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
