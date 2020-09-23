<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import TextArea from "../../../../components/forms/textarea.svelte";
  import Select from "../../../../components/forms/select.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let attachment = {};
  export let languages = [];

  if (!attachment.fields.languageId.value) {
    attachment.fields.languageId.value = "0";
  }
</script>

<div class="bg-white">
  <div class="form-row">
    <div class="w-full md:w-2/3">
      <TextInput
        bind:value={attachment.fields.title.value}
        error={attachment.fields.title.error}
        label="Title"
        focused={true}
        hintMessage={attachment.fields.title.message} />
    </div>
    <div class="w-full md:w-1/3 md:ml-10">
      <Select
        bind:value={attachment.fields.languageId.value}
        error={attachment.fields.languageId.error}
        options={languages}
        defaultOption={{ name: 'All', id: '0' }}
        label="Language"
        hintMessage={attachment.fields.languageId.message} />
    </div>
  </div>
  <div class="form-row">
    <input type="file" name="fileName" bind:files={attachment.fields.files} />
  </div>
</div>
