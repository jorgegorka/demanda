<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import NumberInput from "../../../../components/forms/number_input.svelte";
  import DateInput from "../../../../components/forms/date_input.svelte";
  import Select from "../../../../components/forms/select.svelte";
  import Checkbox from "../../../../components/forms/check_box.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let tax = {};
  export let categories = [];
  export let submitText = "";
  export let disableAction = false;

  let isCustomerDisabled = false;
  let isCategoryDisabled = false;
  let isProductDisabled = false;

  function customerSelect(event) {
    tax.fields.customer = event.detail;
  }

  function validId(field) {
    return field.value && field.value !== "0";
  }

  $: if (
    tax.fields.customerId.value ||
    tax.fields.categoryId.value ||
    tax.fields.productId.value
  ) {
    isCustomerDisabled =
      validId(tax.fields.categoryId) || validId(tax.fields.productId);
    isCategoryDisabled =
      validId(tax.fields.customerId) || validId(tax.fields.productId);
    isProductDisabled =
      validId(tax.fields.customerId) || validId(tax.fields.categoryId);
  }
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <div class="form-row">
      <div class="hidden md:block md:w-1/4 p-3 ">
        <p class="text-lg text-gray-800">Tax info</p>
        <p class="text-sm text-gray-600">Required information for the tax</p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-2/3">
            <TextInput
              bind:value={tax.fields.name.value}
              error={tax.fields.name.error}
              label="Name"
              isFocused={true}
              hintMessage={tax.fields.name.message} />
          </div>
          <div class="w-full md:w-1/3 md:ml-10">
            <Checkbox bind:checked={tax.fields.active.value} label="Active" />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={tax.fields.percentage.value}
              error={tax.fields.percentage.error}
              label="Percentage"
              hintMessage={tax.fields.percentage.message} />
          </div>
          <div class="w-full md:w-1/2">
            <NumberInput
              bind:value={tax.fields.amount.value}
              error={tax.fields.amount.error}
              label="Amount"
              hintMessage={tax.fields.amount.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <DateInput
              bind:value={tax.fields.startAt.value}
              error={tax.fields.startAt.error}
              label="Enable on"
              hintMessage={tax.fields.startAt.message} />
          </div>
          <div class="w-full md:w-1/2">
            <DateInput
              bind:value={tax.fields.endAt.value}
              error={tax.fields.endAt.error}
              label="Disable after"
              hintMessage={tax.fields.endAt.message} />
          </div>
        </div>
      </div>
    </div>
    <div class="mt-4 form-row">
      <div class="hidden md:block md:w-1/4 p-3 ">
        <p class="text-lg text-gray-800">Conditions</p>
        <p class="text-sm text-gray-600">
          Tax will be applied when all these conditions are met.
        </p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={tax.fields.minimumPrice.value}
              error={tax.fields.minimumPrice.error}
              label="Minimum total amount"
              hintMessage={tax.fields.minimumPrice.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={tax.fields.customerId.value}
              error={tax.fields.customerId.error}
              defaultOption={{ id: '0', name: '-- All customers --' }}
              disabled={isCustomerDisabled}
              label="Customer"
              hintMessage={tax.fields.customerId.message} />
          </div>
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={tax.fields.categoryId.value}
              error={tax.fields.categoryId.error}
              defaultOption={{ id: '0', name: '-- All categories --' }}
              options={categories}
              disabled={isCategoryDisabled}
              label="Category"
              hintMessage={tax.fields.categoryId.message} />
          </div>
          <div class="w-full md:w-1/3">
            <Select
              bind:value={tax.fields.productId.value}
              error={tax.fields.productId.error}
              defaultOption={{ id: '0', name: '-- All products --' }}
              disabled={isProductDisabled}
              label="Product"
              hintMessage={tax.fields.productId.message} />
          </div>
        </div>
      </div>
    </div>
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
