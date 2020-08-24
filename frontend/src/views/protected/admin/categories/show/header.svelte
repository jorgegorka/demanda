<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";

  export let category = {};
</script>

<PageHeader title={category.name}>
  <div class="flex items-center">
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
