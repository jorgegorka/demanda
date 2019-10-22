<script>
  export let id = "";
  export let label = "Select";
  export let value = "";
  export let error = false;
  export let hintMessage = "Please select an option";
  export let helpText = "";
  export let options = [];
  export let defaultOption = {};

  $: if (defaultOption.id) {
    options.unshift(defaultOption);
  }
</script>

<div class="input-field">
  <label class="block mt-4" for={id}>
    <span class="text-gray-700">{label}</span>
    <select
      bind:value
      {id}
      class="form-select mt-1 block w-full"
      class:invalid={error}>
      {#each options as option (option.id)}
        <option value={option.id}>{option.name}</option>
      {/each}
    </select>
  </label>

  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
