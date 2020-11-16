<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let language = {};
  export let submitText = "";
  export let disableAction = false;
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Basic data</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">Language information</p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <form on:submit|preventDefault>
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-3">
            <TextInput
              bind:value={language.fields.name.value}
              error={language.fields.name.error}
              label="Name"
              focused={true}
              hintMessage={language.fields.name.message} />
          </div>
          <div class="col-span-3">
            <TextInput
              bind:value={language.fields.code.value}
              error={language.fields.code.error}
              label="Code"
              hintMessage={language.fields.code.message} />
          </div>
        </div>
        <FormButtons
          cancelButton={false}
          {submitText}
          isLoading={disableAction} />
      </form>
    </div>
  </div>
</div>
