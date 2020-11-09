<script>
  import { Route } from "svelte-router-spa";

  import Header from "../../../components/admin/header/index.svelte";
  import Footer from "../../../components/admin/footer/index.svelte";
  import MainMenu from "./main_menu/index.svelte";
  import Notification from "../../../components/toast/index.svelte";
  import LoggedInClient from "../../../components/client/logged_in_client.svelte";

  export let currentRoute;
</script>

<LoggedInClient>
  <div class="app client text-gray-900">
    <Header />
    <main class="flex">
      <aside class="pt-4 hidden md:block w-48 h-screen ">
        <MainMenu {currentRoute} />
      </aside>
      <section class="p-4 bg-gray-200 w-screen">
        <Notification />
        <Route {currentRoute} />
      </section>
    </main>
    <Footer />
  </div>
</LoggedInClient>
