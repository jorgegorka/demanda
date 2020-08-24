<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListDiscounts from "./list/index.svelte";
</script>

<PageHeader title="Discounts">
  <Navigate to="/admin/discounts/new" styles="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add discount
  </Navigate>
</PageHeader>

<ListDiscounts />
