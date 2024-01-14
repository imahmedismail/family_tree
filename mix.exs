defmodule FamilyTree.MixProject do
  use Mix.Project

  def project do
    [
      app: :family_tree,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FamilyTree.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, "~> 0.17.4"},
      {:ecto_sql, "~> 3.1"}
    ]
  end

  defp aliases do
    [
      family_tree: ["run", "family_tree"]
    ]
  end
end
