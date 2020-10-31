<script>
  import TextInput from "../../../../components/forms/text_input.svelte";

  export let user = {};
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Profile</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">
        You can update your profile information here.
      </p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <form action="#" method="POST">
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-6">
            <TextInput
              bind:value={user.fields.name.value}
              error={user.fields.name.error}
              label="Name"
              hintMessage={user.fields.name.message} />
          </div>
          <div class="col-span-6">
            <TextInput
              bind:value={user.fields.phone.value}
              error={user.fields.phone.error}
              label="Telephone"
              hintMessage={user.fields.phone.message} />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
