<script>
  export let inputName = "email";
  export let id = "email";
  export let label = "E-Mail";
  export let value = "";
  export let placeholder = "";
  export let icon = "email";
  export let error = false;
  export let focused = false;
  export let hintMessage = "Please enter a valid email";
</script>

<div class="form-element pb-4">
  <label class="text-gray-700" for={id}>{label}</label>
  <!-- svelte-ignore a11y-autofocus -->
  <div class="relative">
    {#if icon}
      <div
        class="absolute inset-y-0 left-0 pl-2 text-gray-600 flex items-center">
        <svg
          class="w-6 h-6"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"><path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
      </div>
    {/if}
    <input
      bind:value
      autofocus={focused}
      on:blur
      on:input={() => (error = false)}
      name={inputName}
      type="email"
      class="form-input mt-1 block w-full text-lg z-50 {icon ? 'pl-10' : ''}"
      class:invalidInput={error}
      {placeholder} />
  </div>
  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
