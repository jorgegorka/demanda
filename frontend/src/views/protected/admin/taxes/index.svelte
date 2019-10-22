<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListTaxes from "./list/index.svelte";

  export let currentRoute;
  export let params;
</script>

<PageHeader title="Taxes">
  <Navigate to="/admin/taxes/new" styles="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add tax
  </Navigate>
</PageHeader>

<ListTaxes graphqlClient={params.graphqlClient} />
