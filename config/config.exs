import Config

config :centrex, Centrex.Repo,
  database: "centrex_repo",
  username: "postgres",
  password: "docker",
  hostname: "localhost"

config :nostrum,
  token: "MTA1MTMxMjA2OTU1Njg1MDgwOQ.GBdzk4.GPJZpVUnXZDImSVt0OhqVcsS9ayQaDTMI8DgK4"

config :centrex, ecto_repos: [Centrex.Repo]
