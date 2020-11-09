<script>
  import { onMount } from "svelte";
  import { navigateTo } from "svelte-router-spa";

  import Loading from "../loading.svelte";
  import { client } from "../../../lib/config/apollo";
  import { apolloClient } from "../../../lib/stores/apollo_client";
  import { currentUser } from "../../../lib/stores/current_user";
  import { UserSession } from "../../../lib/session";
  import { notificationMessage } from "../../../lib/stores/notification_message";

  let loading = true;
  let userInfo = {};

  $: if ($currentUser.userId) {
    if ($currentUser.userId === "-") {
      navigateTo("/login");
    } else if ($currentUser.userId === "0") {
      notificationMessage.add({
        message: "Please log in to access that page.",
        type: "notice-msg",
      });
      navigateTo("/login");
    }
    userInfo = $currentUser;
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
  <slot {loading} currentUser={userInfo} {currentRoute} {params} />
{/if}
