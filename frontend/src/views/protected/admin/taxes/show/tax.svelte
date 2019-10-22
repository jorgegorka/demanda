<script>
  import PageHeader from "../../../../components/protected/page_header.svelte";

  export let tax = {};
  export let graphqlClient;

  function deleteTax(event) {
    Taxes(graphqlClient)
      .remove(event.detail)
      .then(function() {
        taxesList.refetch();
      });
  }
</script>

<PageHeader title={tax.name}>
  <div class="flex items-center">
    <a
      href={`/admin/taxes/edit/${tax.id}`}
      class="btn secondary flex align-middle">
      <i class="material-icons ">edit</i>
      Edit tax
    </a>
  </div>
</PageHeader>
