import Config

config :centrex, Centrex.Repo,
  database: "centrex_repo",
  username: "postgres",
  password: "docker",
  hostname: "localhost"

config :nostrum,
  token: System.get_env("CENTREX_SECRET")

config :centrex, ecto_repos: [Centrex.Repo]
