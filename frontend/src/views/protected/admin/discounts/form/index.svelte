<script>
  import TextInput from "../../../../components/forms/text_input.svelte";
  import NumberInput from "../../../../components/forms/number_input.svelte";
  import DateInput from "../../../../components/forms/date_input.svelte";
  import Select from "../../../../components/forms/select.svelte";
  import Checkbox from "../../../../components/forms/check_box.svelte";
  import FormButtons from "../../../../components/forms/buttons.svelte";

  export let discount = {};
  export let categories = [];
  export let submitText = "";
  export let disableAction = false;

  let isUserDisabled = false;
  let isCategoryDisabled = false;
  let isProductDisabled = false;

  function userSelect(event) {
    discount.fields.user = event.detail;
  }

  function validId(field) {
    return field.value && field.value !== "0";
  }

  $: if (
    discount.fields.userId.value ||
    discount.fields.categoryId.value ||
    discount.fields.productId.value
  ) {
    isUserDisabled =
      validId(discount.fields.categoryId) || validId(discount.fields.productId);
    isCategoryDisabled =
      validId(discount.fields.userId) || validId(discount.fields.productId);
    isProductDisabled =
      validId(discount.fields.userId) || validId(discount.fields.categoryId);
  }
</script>

<div class="bg-white">
  <form class="p-4" ref="form" on:submit|preventDefault>
    <div class="form-row">
      <div class="hidden md:block md:w-1/4 p-3">
        <p class="text-lg text-gray-800">Discount info</p>
        <p class="text-sm text-gray-600">
          Required information for the discount
        </p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-2/3">
            <TextInput
              bind:value={discount.fields.name.value}
              error={discount.fields.name.error}
              label="Name"
              focused={true}
              hintMessage={discount.fields.name.message} />
          </div>
          <div class="w-full md:w-1/3 md:ml-10">
            <Checkbox
              bind:checked={discount.fields.active.value}
              label="Active" />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={discount.fields.percentage.value}
              error={discount.fields.percentage.error}
              label="Percentage"
              hintMessage={discount.fields.percentage.message} />
          </div>
          <div class="w-full md:w-1/2">
            <NumberInput
              bind:value={discount.fields.amount.value}
              error={discount.fields.amount.error}
              label="Amount"
              hintMessage={discount.fields.amount.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <DateInput
              bind:value={discount.fields.startAt.value}
              error={discount.fields.startAt.error}
              label="Enable on"
              hintMessage={discount.fields.startAt.message} />
          </div>
          <div class="w-full md:w-1/2">
            <DateInput
              bind:value={discount.fields.endAt.value}
              error={discount.fields.endAt.error}
              label="Disable after"
              hintMessage={discount.fields.endAt.message} />
          </div>
        </div>
      </div>
    </div>
    <div class="mt-4 form-row">
      <div class="hidden md:block md:w-1/4 p-3">
        <p class="text-lg text-gray-800">Conditions</p>
        <p class="text-sm text-gray-600">
          Discount will be applied when all these conditions are met.
        </p>
      </div>
      <div class="w-full md:w-3/4">
        <div class="form-row">
          <div class="w-full md:w-1/2 md:mr-4">
            <NumberInput
              bind:value={discount.fields.minimumPrice.value}
              error={discount.fields.minimumPrice.error}
              label="Minimum total amount"
              hintMessage={discount.fields.minimumPrice.message} />
          </div>
          <div class="w-full md:w-1/2">
            <NumberInput
              bind:value={discount.fields.minimumQuantity.value}
              error={discount.fields.minimumQuantity.error}
              label="Minimum quantity"
              hintMessage={discount.fields.minimumQuantity.message} />
          </div>
        </div>
        <div class="form-row">
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={discount.fields.userId.value}
              error={discount.fields.userId.error}
              defaultOption={{ id: '0', name: '-- All users --' }}
              disabled={isUserDisabled}
              label="User"
              hintMessage={discount.fields.userId.message} />
          </div>
          <div class="w-full md:w-1/3 md:mr-4">
            <Select
              bind:value={discount.fields.categoryId.value}
              error={discount.fields.categoryId.error}
              defaultOption={{ id: '0', name: '-- All categories --' }}
              options={categories}
              disabled={isCategoryDisabled}
              label="Category"
              hintMessage={discount.fields.categoryId.message} />
          </div>
          <div class="w-full md:w-1/3">
            <Select
              bind:value={discount.fields.productId.value}
              error={discount.fields.productId.error}
              defaultOption={{ id: '0', name: '-- All products --' }}
              disabled={isProductDisabled}
              label="Product"
              hintMessage={discount.fields.productId.message} />
          </div>
        </div>
      </div>
    </div>
    <FormButtons cancelButton={false} {submitText} isLoading={disableAction} />
  </form>
</div>
