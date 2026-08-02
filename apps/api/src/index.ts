import Fastify from "fastify";

const app = Fastify({ logger: true });

app.get("/health", async () => ({ status: "ok", ts: new Date().toISOString() }));

const port = Number(process.env.API_PORT ?? 4000);

app
  .listen({ port, host: "0.0.0.0" })
  .then(() => app.log.info("API ready on :" + port))
  .catch((err) => {
    app.log.error(err);
    process.exit(1);
  });
