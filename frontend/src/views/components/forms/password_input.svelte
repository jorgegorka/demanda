<script>
  export let inputName = "password";
  export let id = "password";
  export let label = "Contraseña";
  export let value = "";
  export let placeholder = "";
  export let icon = "lock";
  export let error = false;
  export let focused = false;
  export let hintMessage = "At least 6 characters";
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
            d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
      </div>
    {/if}
    <input
      bind:value
      autofocus={focused}
      on:blur
      on:input={() => (error = false)}
      name={inputName}
      type="password"
      class="form-input mt-1 block w-full text-lg z-50 {icon ? 'pl-10' : ''}"
      class:invalidInput={error}
      {placeholder} />
  </div>
  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
