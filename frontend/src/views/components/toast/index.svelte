<script>
  import { onMount, onDestroy } from "svelte";

  import Message from "./message.svelte";
  import { notificationMessage } from "../../../lib/stores/notification_message";

  let unsubscribe;
  let notifications = [];

  function closeNotification(event) {
    notificationMessage.remove(event.detail);
  }

  onMount(function() {
    const unsubscribe = notificationMessage.subscribe(function(
      currentNotifications
    ) {
      notifications = [...currentNotifications];
    });
  });

  onDestroy(function() {
    unsubscribe();
  });
</script>

{#if notifications.length > 0}
  <div
    class="alert-toast fixed bottom-0 md:top-0 right-0 md:m-8 w-5/6 w-full
    md:max-w-sm z-50">
    {#each notifications as notification, index (index)}
      <Message
        {notification}
        {index}
        on:closeNotification={closeNotification} />
    {/each}
  </div>
{/if}
