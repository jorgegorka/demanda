<script>
  import { onMount, createEventDispatcher } from "svelte";

  export let notification = {};
  export let index = 0;

  const dispatch = createEventDispatcher();

  function closeElement() {
    dispatch("closeNotification", index);
  }

  onMount(function () {
    setTimeout(function () {
      dispatch("closeNotification", index);
    }, 3000);
  });
</script>

<!--
    Notification panel, show/hide based on alert state.

    Entering: "transform ease-out duration-300 transition"
      From: "translate-y-2 opacity-0 sm:translate-y-0 sm:translate-x-2"
      To: "translate-y-0 opacity-100 sm:translate-x-0"
    Leaving: "transition ease-in duration-100"
      From: "opacity-100"
      To: "opacity-0"   {notification.type}
  -->
<div class="max-w-sm w-full bg-white shadow-lg rounded-lg pointer-events-auto">
  <div class="rounded-lg shadow-xs overflow-hidden">
    <div class="p-4">
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <svg
            class="h-6 w-6 text-green-400"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        </div>
        <div class="ml-3 w-0 flex-1 pt-0.5">
          <p class="text-sm leading-5 font-medium text-gray-900">
            {notification.message}
          </p>
        </div>
        <div class="ml-4 flex-shrink-0 flex">
          <button
            on:click={closeElement}
            class="inline-flex text-gray-400 focus:outline-none
              focus:text-gray-500 transition ease-in-out duration-150">
            <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path
                fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd" />
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
