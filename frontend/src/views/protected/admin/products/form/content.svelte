<script>
  import marked from "marked";
  import TextInput from "../../../../components/forms/text_input.svelte";
  import Textarea from "../../../../components/forms/textarea.svelte";
  import Buttons from "../../../../components/forms/buttons.svelte";

  export let product;
  let metaDescriptionLength = 0;
  let metaTitleLength = 0;
  let viewMode = false;

  function togglePreview() {
    viewMode = !viewMode;
  }

  $: metaDescriptionLength =
    (product.fields.metaDescription.value &&
      product.fields.metaDescription.value.length) ||
    0;
  $: metaTitleLength =
    (product.fields.metaTitle.value && product.fields.metaTitle.value.length) ||
    0;
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  {#if viewMode}
    <div class="md:grid md:grid-cols-2 md:gap-6">
      <div class="">
        <h3 class="text-lg font-medium leading-6 text-gray-900">Content</h3>
        <p class="mt-1 text-sm leading-5 text-gray-500">Describe the product</p>
        <p class="mt-1">
          <button
            class="inline-flex items-center px-2.5 py-1.5 border
              border-transparent text-xs leading-4 font-medium rounded
              text-indigo-700 bg-indigo-100 hover:bg-indigo-50
              focus:outline-none focus:border-indigo-300
              focus:shadow-outline-indigo active:bg-indigo-200 transition
              ease-in-out duration-150"
            on:click={togglePreview}>Edit</button>
        </p>
      </div>
      <div class="mt-5 md:mt-0">
        <p>
          {@html marked(product.fields.summary.value)}
        </p>
        <p>
          {@html marked(product.fields.description.value)}
        </p>
      </div>
    </div>
  {:else}
    <div class="md:grid md:grid-cols-3 md:gap-6">
      <div class="md:col-span-1">
        <h3 class="text-lg font-medium leading-6 text-gray-900">Content</h3>
        <p class="mt-1 text-sm leading-5 text-gray-500">Describe the product</p>
        <p class="mt-1">
          <button
            class="inline-flex items-center px-2.5 py-1.5 border
              border-transparent text-xs leading-4 font-medium rounded
              text-indigo-700 bg-indigo-100 hover:bg-indigo-50
              focus:outline-none focus:border-indigo-300
              focus:shadow-outline-indigo active:bg-indigo-200 transition
              ease-in-out duration-150"
            on:click={togglePreview}>Preview</button>
        </p>
      </div>
      <div class="mt-5 md:mt-0 md:col-span-2">
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-6">
            <Textarea
              bind:value={product.fields.summary.value}
              error={product.fields.summary.error}
              label="Summary"
              hintMessage={product.fields.summary.message} />
          </div>
          <div class="col-span-6">
            <Textarea
              bind:value={product.fields.description.value}
              error={product.fields.description.error}
              label="Long Description"
              hintMessage={product.fields.description.message} />
          </div>
          <div class="col-span-6">
            <TextInput
              bind:value={product.fields.metaTitle.value}
              error={product.fields.metaTitle.error}
              label="Meta title (chars: {metaTitleLength})"
              hintMessage={product.fields.metaTitle.message} />
          </div>
          <div class="col-span-6">
            <Textarea
              bind:value={product.fields.metaDescription.value}
              error={product.fields.metaDescription.error}
              label="Meta description (chars: {metaDescriptionLength})"
              hintMessage={product.fields.metaDescription.message} />
          </div>
        </div>
      </div>
    </div>
  {/if}
</div>
