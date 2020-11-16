<script>
  import TextInput from "../../../../components/forms/text_input.svelte";

  export let category;
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Basic data</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">
        Basic category information
      </p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <form action="#" method="POST">
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-6">
            <TextInput
              bind:value={category.fields.name.value}
              error={category.fields.name.error}
              label="Name"
              focused={true}
              hintMessage={category.fields.name.message} />
          </div>
          <div class="col-span-6">
            <TextInput
              bind:value={category.fields.slug.value}
              error={category.fields.slug.error}
              label="Slug"
              hintMessage={category.fields.slug.message} />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
