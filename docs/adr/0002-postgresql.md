# ADR-0002: PostgreSQL as primary datastore

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Parts data is highly relational (board <-> CPU support lists, product <->
variant <-> price snapshots). We also need flexible storage for
vendor-specific spec quirks.

## Decision

PostgreSQL 16 for everything: relational core plus JSONB columns for
vendor-specific extras. Prisma for schema, migrations, and the typed client.

## Alternatives considered

- **MongoDB** — flexible, but joins (board <-> QVL <-> price) are the core of
  this product; a document store fights us.
- **MySQL** — viable, but Postgres JSONB, generated columns, and pg_trgm
  (fuzzy SKU matching in Phase 5) tip the balance.

## Consequences

- One database to operate and back up.
- Search (Meilisearch) and cache (Redis) are added later as satellites, not
  replacements.
