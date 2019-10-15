<script>
  import { onMount } from "svelte";
  import { Route, navigateTo } from "svelte-router-spa";

  import Loading from "../../../components/loading.svelte";
  // import Menu from "./menu.svelte";
  // import Footer from "./footer.svelte";
  import Notification from "../../../components/toast/index.svelte";
  import { notificationMessage } from "../../../../lib/stores/notification_message";
  import { client } from "../../../../lib/config/apollo";
  import { apolloClient } from "../../../../lib/stores/apollo_client";
  import { UserSession } from "../../../../lib/session";
  import { currentUser } from "../../../../lib/stores/current_user";

  export let currentRoute;
  export let params = {};
  let userInfo = {};
  let loading = true;

  $: if ($currentUser.userId) {
    userInfo = $currentUser;
    if (userInfo.userId === "0") {
      notificationMessage.add({
        message: "Please log in to access this page.",
        type: "warning-msg"
      });
      navigateTo("/login");
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
  <div class="app client">
    <!-- <Menu /> -->
    <main>
      <Route {currentRoute} params={{ currentUser: userInfo }} />
    </main>
    <!-- <Footer /> -->
  </div>
{/if}
