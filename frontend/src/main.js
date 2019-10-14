import App from "./App.svelte";
import { SpaRouter } from "svelte-router-spa";
import { routes } from "./routes";
import "./tailwind.css";

SpaRouter(routes, document.location.href).currentRoute;

const app = new App({
  target: document.body,
  props: {}
});

export default app;
