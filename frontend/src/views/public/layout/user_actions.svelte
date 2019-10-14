<script>
  import { onMount, onDestroy } from "svelte";
  import { setClient } from "svelte-apollo";
  import { Route } from "svelte-router-spa";

  import Notification from "../../components/toast/index.svelte";
  import { client } from "../../../lib/config/apollo";
  import { apolloClient } from "../../../lib/stores/apollo_client";
  import { UserSession } from "../../../lib/session";
  import { currentUser } from "../../../lib/stores/current_user";

  export let currentRoute;
  export let params = {};

  let userInfo = {};

  $: if (!$currentUser.userId) {
    UserSession.get();
  }

  $: if ($currentUser.userId) {
    userInfo = $currentUser;
  }

  onMount(function() {
    apolloClient.set(client);
  });
</script>

<div class="app bg-gray-600">
  <Notification />
  <main>
    <Route {currentRoute} params={{ currentUser: userInfo }} />
  </main>
</div>
