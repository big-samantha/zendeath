# Zendeath

An open source command-line client for Zendesk.

Primarly created as a learning experience.

Copy `config.yaml.example` to `config.yaml` and fill in relevant
details.

Current commands include:

  * me - Shows what Zendesk knows about the current user.
  * localinfo - Shows config data.
  * alltickets - Shows total number of tickets, plus number of unsolved
tickets.
  * myworking - Shows your current working tickets + some data.

Currently has no external dependencies for real functionality, but
requires pry because reasons.

No tests because I don't know how to write tests yet.
