<script>
  import { onMount } from "svelte";
  import { Route, navigateTo } from "svelte-router-spa";

  import Loading from "../../components/loading.svelte";
  import { notificationMessage } from "../../../lib/stores/notification_message";
  import { client } from "../../../lib/config/apollo";
  import { apolloClient } from "../../../lib/stores/apollo_client";
  import { UserSession } from "../../../lib/session";
  import { currentUser } from "../../../lib/stores/current_user";

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
        type: "notice-msg",
      });
      navigateTo("/login");
    }
    loading = false;
  }

  onMount(function () {
    apolloClient.set(client);
    UserSession.get();
  });
</script>

{#if loading}
  <Loading />
{:else}
  <Route {currentRoute} params={{ currentUser: $currentUser }} />
{/if}
