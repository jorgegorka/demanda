<script>
  export let title = "";
</script>

<div class="mb-4 p-4 flex justify-between items-center rounded shadow bg-white">
  <h1 class="text-2xl font-display font-semibold">{title}</h1>
  <div>
    <slot />
  </div>
</div>
