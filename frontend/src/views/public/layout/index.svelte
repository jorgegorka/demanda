<script>
  import { Route } from "svelte-router-spa";
  import Menu from "./menu.svelte";
  import Footer from "./footer.svelte";

  export let currentRoute;
  export let params = {};
</script>

<div class="app">
  <Menu />
  <main>
    <Route {currentRoute} />
  </main>
  <Footer />
</div>
