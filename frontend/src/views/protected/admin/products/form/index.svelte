<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import NumberInput from "../../../../components/forms/number_input.svelte";
  import Select from "../../../../components/forms/select.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let product = {};
  export let categories = [];
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <div class="form-row">
      <div class="hidden md:block md:w-1/4 p-3 ">
        <p class="text-lg text-gray-800">Product</p>
        <p class="text-sm text-gray-600">Basic product information</p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-2/3">
            <TextInput
              bind:value={product.fields.name.value}
              error={product.fields.name.error}
              label="Name"
              isFocused={true}
              hintMessage={product.fields.name.message} />
          </div>
          <div class="w-full min-h-full md:w-1/3 md:ml-10">
            <Select
              bind:value={product.fields.categoryId.value}
              error={product.fields.categoryId.error}
              defaultOption={{ id: '0', name: '-- All categories --' }}
              options={categories}
              id="category"
              label="Category"
              hintMessage={product.fields.categoryId.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={product.fields.price.value}
              error={product.fields.price.error}
              label="Price"
              hintMessage={product.fields.price.message} />
          </div>
          <div class="w-full md:w-1/2">
            <NumberInput
              bind:value={product.fields.stock.value}
              error={product.fields.stock.error}
              label="Stock quantity"
              hintMessage={product.fields.stock.message} />
          </div>
        </div>
      </div>
    </div>
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
