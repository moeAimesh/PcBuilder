# PC Build Companion — Monorepo

Region- and budget-aware PC building, upgrade, and diagnostics platform.

## Prerequisites

- Node.js >= 20 (LTS) — https://nodejs.org
- pnpm >= 9 — `npm install -g pnpm`
- Docker Desktop (or Docker Engine + Compose)
- Git

## Quick start

```bash
pnpm install            # install all workspace dependencies
cp .env.example .env    # local config (never commit .env)
docker compose up -d    # start Postgres + Redis
pnpm db:migrate         # create the database schema
pnpm dev                # run everything in dev mode
```

## Repository layout

```
apps/
  api/          Fastify backend (REST API)
  web/          Next.js frontend (create with: pnpm create next-app apps/web)
packages/
  db/           Prisma schema + generated client (shared by api and ETL)
  shared/       Zod schemas + TypeScript types shared across the stack
etl/            Scrapers, parsers, and ingestion scripts (Phase 2)
docs/
  adr/          Architecture Decision Records
```

## Conventions

- Conventional commits: `feat:`, `fix:`, `chore:`, `docs:`, `data:`
- Every non-trivial decision gets an ADR in `docs/adr/`
- CI must be green before merging to `main`
