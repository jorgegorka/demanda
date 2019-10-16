<script>
  export let message = "";
</script>

<div class="mb-4 p-4 flex justify-between items-center rounded bg-blue-100">
  <p class="text-lg text-blue-600 ">{message}</p>
  <div>
    <slot />
  </div>
</div>
