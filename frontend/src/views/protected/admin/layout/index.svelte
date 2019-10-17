<script>
  import { onMount } from "svelte";
  import { Route, navigateTo } from "svelte-router-spa";

  import Loading from "../../../components/loading.svelte";
  import Header from "./header/index.svelte";
  import Footer from "./footer/index.svelte";
  import MainMenu from "./main_menu/index.svelte";
  import Notification from "../../../components/toast/index.svelte";
  import { notificationMessage } from "../../../../lib/stores/notification_message";
  import { client } from "../../../../lib/config/apollo";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { UserSession } from "../../../../lib/session";
  import { currentUser } from "../../../../lib/stores/current_user";

  export let currentRoute;
  export let params = {};
  let loading = true;

  $: if ($currentUser.userId) {
    // user has been logged out now
    if ($currentUser.userId === "-") {
      navigateTo("/login");
    } else if ($currentUser.userId === "0") {
      notificationMessage.add({
        message: "Please log in to access that page.",
        type: "notice-msg"
      });
      navigateTo("/login");
    } else if ($currentUser.role !== "admin") {
      notificationMessage.add({
        message: "Sorry, you don't have permission to access this page.",
        type: "warning-msg"
      });
      navigateTo("/client");
    }
    loading = false;
  }

  onMount(function() {
    apolloClient.set(client);
    UserSession.get();
  });
</script>

{#if loading}
  <Loading />
{:else}
  <div class="app admin text-gray-900">
    <Header />
    <main class="flex">
      <aside class="pt-4 hidden md:block w-48 h-screen ">
        <MainMenu />
      </aside>
      <section class="p-4 bg-gray-200 w-screen">
        <Notification />
        <Route
          {currentRoute}
          params={{ currentUser: $currentUser, graphqlClient: $apolloClient }} />
      </section>
    </main>
    <Footer />
  </div>
{/if}
