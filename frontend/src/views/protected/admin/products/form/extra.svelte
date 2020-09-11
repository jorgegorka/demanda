<script>
  import TextInput from "../../../../components/forms/text_input.svelte";

  export let product;
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Extra data</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">
        Additional product information
      </p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <div class="grid grid-cols-6 gap-6">
        <div class="col-span-6">
          <TextInput
            bind:value={product.fields.tags.value}
            error={product.fields.tags.error}
            label="Tags"
            isFocused={true}
            hintMessage={product.fields.tags.message} />
        </div>
      </div>
    </div>
  </div>
</div>
