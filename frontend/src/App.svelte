<script>
  import { Router } from "svelte-router-spa";
  import { routes } from "./routes";
</script>

<Router {routes} options={{ gaPageviews: true }} />
