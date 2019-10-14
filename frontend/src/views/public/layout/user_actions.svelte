<script>
  import { onMount, onDestroy } from "svelte";
  import { client } from "../../../lib/config/apollo";
  import { setClient } from "svelte-apollo";
  import { Route } from "svelte-router-spa";
  import Notification from "../../components/toast/index.svelte";
  import { notificationMessage } from "../../../lib/stores/notification_message";
  import { apolloClient } from "../../../lib/stores/apollo_client";

  export let currentRoute;
  export let params = {};

  let visible = false;
  let notification = "";
  let unsubscribe;

  onMount(function() {
    apolloClient.set(client);
    unsubscribe = notificationMessage.subscribe(function(currentNotification) {
      if (
        currentNotification.message &&
        currentNotification.message.length > 0
      ) {
        notification = currentNotification;
        visible = true;
      } else {
        visible = false;
      }
    });
  });

  onDestroy(function() {
    unsubscribe();
  });
</script>

<div class="app bg-gray-600">
  <Notification
    notification={{ message: 'Hola a todo el mundo mundial' }}
    visible={true} />
  <main>
    <Route {currentRoute} />
  </main>
</div>
