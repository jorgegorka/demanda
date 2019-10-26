<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListProducts from "./list/index.svelte";

  export let currentRoute;
  export let params;
</script>

<PageHeader title="Products">
  <Navigate to="/admin/products/new" styles="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add product
  </Navigate>
</PageHeader>

<ListProducts graphqlClient={params.graphqlClient} />
