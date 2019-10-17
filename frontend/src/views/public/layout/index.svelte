<script>
  import { Route } from "svelte-router-spa";

  import Notification from "../../components/toast/index.svelte";
  import Menu from "./menu.svelte";
  import Footer from "./footer.svelte";

  export let currentRoute;
  export let params = {};
</script>

<div class="app">
  <Menu />
  <main>
    <Notification />
    <Route {currentRoute} {params} />
  </main>
  <Footer />
</div>
