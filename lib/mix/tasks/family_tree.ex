defmodule Mix.Tasks.FamilyTree do
  use Mix.Task
  alias FamilyTree.Commands

  def loop do
    IO.puts("-------------------------------------")
    IO.puts("Type any command: ")
    command = IO.gets("") |> String.trim()

    case String.split(command, " ") do
      ["family-tree", "add", "person" | name] ->
        Commands.add_person(name)
        loop()

      ["family-tree", "add", "relationship", relation] ->
        Commands.add_relation(relation)
        loop()

      ["family-tree", "connect" | names_and_relationship] ->
        [[name1 | tail_name1], ["as"], [relation], ["of"], [name2 | tail_name2]] =
          names_and_relationship |> Enum.chunk_by(&(&1 == "as" or &1 == "of"))

        Commands.connect_relation("#{name1} #{tail_name1}", "#{name2} #{tail_name2}", relation)
        loop()

      ["family-tree", "count" | relation_and_name] ->
        [[relation], ["of"], [name | tail]] = relation_and_name |> Enum.chunk_by(&(&1 == "of"))
        Commands.count(extract_without_last_letter(relation), "#{name} #{tail}")
        loop()

      ["family-tree", "father", "of" | name] ->
        Commands.father_of(name)
        loop()

      _ ->
        IO.puts("Command not found!")
        loop()
    end
  end

  def extract_without_last_letter(str) when is_binary(str) do
    case String.length(str) do
      0 -> ""
      _ -> String.slice(str, 0..-2)
    end
  end

  @impl Mix.Task
  def run(_) do
    IO.puts("-------------------------------------")
    IO.puts("- FAMILY TREE Elixir CLI -")
    IO.puts("-------------------------------------")
    IO.puts("Here some possibilities")
    IO.puts(" family-tree add person <name> - add a new person")
    IO.puts(" family-tree add relationship <name> - add a relationship")

    IO.puts(
      " family-tree connect <name 1> as <relationship> of <name 2> - connect 1 person to another"
    )

    IO.puts(" family-tree count sons of <name> - counts the son of a person")
    IO.puts(" family-tree count daughters of <name> - counts the daughters of a person")
    IO.puts(" family-tree count wives of <name> - counts the wives of a person")
    IO.puts(" family-tree father of <name> - counts the father of a person")
    IO.puts("-------------------------------------")

    loop()
  end
end
