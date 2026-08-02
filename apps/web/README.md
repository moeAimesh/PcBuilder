# Web app (Next.js)

Not vendored on purpose — generate it fresh so you get current versions:

```bash
pnpm create next-app@latest apps/web --typescript --tailwind --eslint --app --src-dir --use-pnpm
```

Then add to apps/web/package.json scripts if missing:
- "typecheck": "tsc --noEmit"
- "test": "echo 'no tests yet'"
