# Family Tree Elixir CLI

## Overview

The Family Tree Elixir CLI is a command-line tool built in Elixir for managing and querying family tree relationships. It provides a set of commands to add individuals, define relationships, and perform various queries on the family tree.

## Features

- **Add a Person:** Add a new person to the family tree.
- **Add Relationship:** Define a new relationship type in the family tree.
- **Connect Individuals:** Connect two individuals in the family tree with a specified relationship.
- **Count Relationships:** Count the number of specific relationships for a given individual.
- **Find Father:** Find the father of a specified individual.

## Installation / Running the project

Ensure you have Elixir and Postgres installed on your machine. Then, follow these steps:

```bash
  1: cd family-tree
  2: mix family_tree 
```

Now you can run the following commands:

```
  1. family-tree add person <name>
  2. family-tree add relationship <name>
  3. family-tree connect <name 1> as <relationship> of <name 2>
  4. family-tree count sons of <name>
  5. family-tree count daughters of <name>
  6. family-tree count wives of <name>
  7. family-tree father of <name>
```