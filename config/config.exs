use Mix.Config

config :family_tree, :ecto_repos, [FamilyTree.Repo]

config :family_tree, FamilyTree.Repo,
  username: "postgres",
  password: "postgres",
  database: "family_tree_dev",
  hostname: "localhost",
  pool_size: 10

config :telemetry, :span_options,
  telemetry_prefix: [:family_tree, FamilyTree.Repo],
  timeout: 15_000,
  pool_size: 10
