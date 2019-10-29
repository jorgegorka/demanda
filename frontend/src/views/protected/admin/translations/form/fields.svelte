<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import TextArea from "../../../../components/forms/textarea.svelte";
  import Select from "../../../../components/forms/select.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let translation = {};
  export let languages = [];
  export let submitText = "";
  export let disableAction = false;

  if (!translation.fields.languageId.value) {
    translation.fields.languageId.value = languages[0].id;
  }
</script>

<div class="bg-white">
  <div class="form-row">
    <div class="w-full md:w-2/3">
      <TextInput
        bind:value={translation.fields.name.value}
        error={translation.fields.name.error}
        label="Short translation"
        isFocused={true}
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
      label="Long translation"
      hintMessage={translation.fields.description.message} />
  </div>
</div>
