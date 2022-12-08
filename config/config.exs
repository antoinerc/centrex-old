import Config

config :centrex, Centrex.Repo,
  database: "centrex_repo",
  username: "postgres",
  password: "docker",
  hostname: "localhost"

config :centrex, ecto_repos: [Centrex.Repo]
