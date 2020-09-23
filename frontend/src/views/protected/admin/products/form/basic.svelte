<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import NumberInput from "../../../../components/forms/number_input.svelte";
  import Select from "../../../../components/forms/select.svelte";

  export let product;
  export let categories;
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Basic data</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">
        Basic product information
      </p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <form action="#" method="POST">
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-6 sm:col-span-3">
            <TextInput
              bind:value={product.fields.name.value}
              error={product.fields.name.error}
              label="Name"
              focused={true}
              hintMessage={product.fields.name.message} />
          </div>

          <div class="col-span-6 sm:col-span-3">
            <Select
              bind:value={product.fields.categoryId.value}
              error={product.fields.categoryId.error}
              defaultOption={{ id: '0', name: '-- All categories --' }}
              options={categories}
              id="category"
              label="Category"
              hintMessage={product.fields.categoryId.message} />
          </div>

          <div class="col-span-6 sm:col-span-3">
            <NumberInput
              bind:value={product.fields.price.value}
              error={product.fields.price.error}
              label="Price"
              hintMessage={product.fields.price.message} />
          </div>

          <div class="col-span-6 sm:col-span-3">
            <NumberInput
              bind:value={product.fields.stock.value}
              error={product.fields.stock.error}
              label="Stock quantity"
              hintMessage={product.fields.stock.message} />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
