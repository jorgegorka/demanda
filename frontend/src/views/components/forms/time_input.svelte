<script>
  export let inputName = "time";
  export let id = "time";
  export let label = "";
  export let placeholder = "";
  export let value = "";
  export let icon = null;
  export let error = false;
  export let focused = false;
  export let hintMessage = "Please enter a time";
</script>

<div class="form-element pb-4">
  <label class="text-gray-700" for={id}>{label}</label>
  <!-- svelte-ignore a11y-autofocus -->
  <div class="relative">
    {#if icon}
      <div
        class="absolute inset-y-0 left-0 pl-2 text-gray-600 flex items-center">
        <i class="material-icons">{icon}</i>
      </div>
    {/if}
    <input
      bind:value
      autofocus={focused}
      on:blur
      on:input={() => (error = false)}
      name={inputName}
      type="time"
      class="form-input mt-1 block w-full text-lg z-50 {icon ? 'pl-10' : ''}"
      class:invalidInput={error}
      {placeholder} />
  </div>
  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
