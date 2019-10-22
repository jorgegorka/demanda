<script>
  export let id = "checkbox";
  export let label = "";
  export let group = "radio";
  export let checked = false;
</script>

<div class="radio-field">
  <label for={id} class="flex items-center">
    <input
      type="checkbox"
      {id}
      bind:checked
      class="form-checkbox text-purple-600" />
    <span class="ml-2">{label}</span>
  </label>
</div>
