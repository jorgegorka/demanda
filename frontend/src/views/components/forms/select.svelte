<script>
  export let id = "";
  export let label = "Select";
  export let value = "";
  export let error = false;
  export let disabled = false;
  export let hintMessage = "Please select an option";
  export let options = [];
  export let defaultOption = {};
</script>

<div class="input-field pb-4">
  <label class="block" for={id}>
    <span class="text-gray-700">{label}</span>
    <select
      bind:value
      {id}
      {disabled}
      class="form-select w-full mt-1"
      class:invalid={error}>
      {#each [defaultOption, ...options] as option (option.id)}
        <option value={option.id}>{option.name}</option>
      {/each}
    </select>
  </label>

  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
