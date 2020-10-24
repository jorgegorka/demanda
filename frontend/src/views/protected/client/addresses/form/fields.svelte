<script>
  import Select from "../../../../components/forms/select.svelte";
  import TextInput from "../../../../components/forms/text_input.svelte";

  export let address = {};
  export let countries = [];
</script>

<div class="mt-6 bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
  <div class="md:grid md:grid-cols-3 md:gap-6">
    <div class="md:col-span-1">
      <h3 class="text-lg font-medium leading-6 text-gray-900">Address</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">
        Enter your address info. If you have more than one address you can add
        an optional name to differenciate them, for instance,
        <em>home</em>
        or
        <em>office</em>.
      </p>
    </div>
    <div class="mt-5 md:mt-0 md:col-span-2">
      <form action="#" method="POST">
        <div class="grid grid-cols-6 gap-6">
          <div class="col-span-6">
            <TextInput
              bind:value={address.fields.name.value}
              error={address.fields.name.error}
              label="Name"
              hintMessage={address.fields.name.message} />
          </div>
          <div class="col-span-6">
            <TextInput
              bind:value={address.fields.firstAddress.value}
              error={address.fields.firstAddress.error}
              label="Direccion"
              focused={true}
              hintMessage={address.fields.firstAddress.message} />
          </div>
          <div class="col-span-6">
            <TextInput
              bind:value={address.fields.secondAddress.value}
              error={address.fields.secondAddress.error}
              label="Direccion 2"
              hintMessage={address.fields.secondAddress.message} />
          </div>
          <div class="col-span-6 sm:col-span-3  lg:col-span-2">
            <TextInput
              bind:value={address.fields.postalCode.value}
              error={address.fields.postalCode.error}
              label="Postal Code"
              hintMessage={address.fields.postalCode.message} />
          </div>
          <div class="col-span-6 sm:col-span-3  lg:col-span-2">
            <TextInput
              bind:value={address.fields.city.value}
              error={address.fields.city.error}
              label="City"
              hintMessage={address.fields.city.message} />
          </div>
          <div class="col-span-6 lg:col-span-2">
            <Select
              bind:value={address.fields.country.value}
              error={address.fields.country.error}
              options={countries}
              label="Country"
              hintMessage={address.fields.country.message} />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
