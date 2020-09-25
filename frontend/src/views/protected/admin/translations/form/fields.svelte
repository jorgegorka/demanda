<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import TextArea from "../../../../components/forms/textarea.svelte";
  import Select from "../../../../components/forms/select.svelte";

  export let translation = {};
  export let languages = [];

  let descriptionLength = 0;

  if (!translation.fields.languageId.value) {
    translation.fields.languageId.value = languages[0].id;
  }

  $: descriptionLength =
    (translation.fields.description.value &&
      translation.fields.description.value.length) ||
    0;
</script>

<div class="bg-white">
  <div class="form-row">
    <div class="w-full md:w-2/3">
      <TextInput
        bind:value={translation.fields.name.value}
        error={translation.fields.name.error}
        label="Name"
        focused={true}
        hintMessage={translation.fields.name.message} />
    </div>
    <div class="w-full md:w-1/3 md:ml-10">
      <Select
        bind:value={translation.fields.languageId.value}
        error={translation.fields.languageId.error}
        options={languages}
        label="Language"
        hintMessage={translation.fields.languageId.message} />
    </div>
  </div>
  <div class="form-row">
    <TextArea
      bind:value={translation.fields.description.value}
      error={translation.fields.description.error}
      label="Text (chars: {descriptionLength})"
      hintMessage={translation.fields.description.message} />
  </div>
</div>
