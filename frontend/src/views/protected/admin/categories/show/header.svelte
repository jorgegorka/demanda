<script>
  import { createEventDispatcher } from "svelte";

  import PageHeader from "../../../../components/protected/page_header.svelte";

  export let category = {};

  const dispatch = createEventDispatcher();
</script>

<PageHeader title={category.name}>
  <div class="flex items-center">
    <a href={`/admin/media/category/${category.id}`} class="btn-primary mr-8">
      <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
        <path
          fill-rule="evenodd"
          d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
          clip-rule="evenodd" />
      </svg>
      Add Media content
    </a>

    <a href="#!" on:click={() => dispatch('addTranslation')} class="btn-primary mr-8">
      <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
        <path
          fill-rule="evenodd"
          d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
          clip-rule="evenodd" />
      </svg>
      Add Translation
    </a>

    <a href={`/admin/categories/edit/${category.id}`} class="btn-secondary flex align-middle">
      <svg viewBox="0 0 20 20" fill="currentColor" class="pencil w-6 h-6">
        <path
          d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3
          14.172V17h2.828l8.38-8.379-2.83-2.828z" />
      </svg>
      Edit category
    </a>
  </div>
</PageHeader>
