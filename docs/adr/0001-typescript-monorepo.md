# ADR-0001: TypeScript monorepo with pnpm + Turborepo

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

The product spans a web frontend, an API, ETL scripts, and (later) an agent
layer. The parts-catalog schema has 100+ fields; type drift between backend
and frontend would be a constant source of bugs. Team is small — one language
across the stack minimizes context switching.

## Decision

TypeScript everywhere, organized as a pnpm-workspace monorepo with Turborepo
for task orchestration. Shared types live in \`packages/shared\` (Zod schemas,
inferred types); the Prisma client in \`packages/db\` is consumed by both the
API and ETL scripts.

## Alternatives considered

- **Python backend + TS frontend** — better agent-library ecosystem, but
  splits the stack and loses shared types. Revisit for the agent service in
  Phase 8 (it can be a separate Python service if needed).
- **Nx instead of Turborepo** — more powerful generators/boundaries, more
  complexity than a small team needs now.

## Consequences

- Single \`pnpm install\`, single CI pipeline, shared lint/format config.
- The agent layer may later justify a polyglot exception (documented in a
  future ADR if so).
