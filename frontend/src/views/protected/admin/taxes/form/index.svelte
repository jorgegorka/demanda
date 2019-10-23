<script>
  import { createEventDispatcher } from "svelte";

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

  const dispatch = createEventDispatcher();
  let formFields = tax.fields();
  let isCustomerDisabled = false;
  let isCategoryDisabled = false;
  let isProductDisabled = false;

  function customerSelect(event) {
    formFields.customer = event.detail;
  }

  function validId(field) {
    return field.value && field.value !== "0";
  }

  function submitTax() {
    const { fieldsInfo, valid } = tax.valid(formFields);
    formFields = { ...fieldsInfo };

    if (valid) {
      dispatch("validInfo", tax.validValues(formFields));
    }
  }

  $: if (
    formFields.customerId.value ||
    formFields.categoryId.value ||
    formFields.productId.value
  ) {
    isCustomerDisabled =
      validId(formFields.categoryId) || validId(formFields.productId);
    isCategoryDisabled =
      validId(formFields.customerId) || validId(formFields.productId);
    isProductDisabled =
      validId(formFields.customerId) || validId(formFields.categoryId);
  }
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault={submitTax}>
    <div class="form-row">
      <div class="hidden md:block md:w-1/4 p-3 ">
        <p class="text-lg text-gray-800">Tax info</p>
        <p class="text-sm text-gray-600">Required information for the tax</p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-2/3">
            <TextInput
              bind:value={formFields.name.value}
              error={formFields.name.error}
              label="Name"
              isFocused={true}
              hintMessage={formFields.name.message} />
          </div>
          <div class="w-full md:w-1/3 md:ml-10">
            <Checkbox bind:checked={formFields.active.value} label="Active" />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={formFields.percentage.value}
              error={formFields.percentage.error}
              label="Percentage"
              hintMessage={formFields.percentage.message} />
          </div>
          <div class="w-full md:w-1/2">
            <NumberInput
              bind:value={formFields.amount.value}
              error={formFields.amount.error}
              label="Amount"
              hintMessage={formFields.amount.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <DateInput
              bind:value={formFields.startAt.value}
              error={formFields.startAt.error}
              label="Enable on"
              hintMessage={formFields.startAt.message} />
          </div>
          <div class="w-full md:w-1/2">
            <DateInput
              bind:value={formFields.endAt.value}
              error={formFields.endAt.error}
              label="Disable after"
              hintMessage={formFields.endAt.message} />
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
              bind:value={formFields.minimumPrice.value}
              error={formFields.minimumPrice.error}
              label="Minimum total amount"
              hintMessage={formFields.minimumPrice.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={formFields.customerId.value}
              error={formFields.customerId.error}
              defaultOption={{ id: '0', name: '-- All customers --' }}
              disabled={isCustomerDisabled}
              label="Customer"
              hintMessage={formFields.customerId.message} />
          </div>
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={formFields.categoryId.value}
              error={formFields.categoryId.error}
              defaultOption={{ id: '0', name: '-- All categories --' }}
              options={categories}
              disabled={isCategoryDisabled}
              label="Category"
              hintMessage={formFields.categoryId.message} />
          </div>
          <div class="w-full md:w-1/3">
            <Select
              bind:value={formFields.productId.value}
              error={formFields.productId.error}
              defaultOption={{ id: '0', name: '-- All products --' }}
              disabled={isProductDisabled}
              label="Product"
              hintMessage={formFields.productId.message} />
          </div>
        </div>
      </div>
    </div>
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
