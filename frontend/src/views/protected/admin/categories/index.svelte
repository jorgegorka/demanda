<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListCategories from "./list/index.svelte";
</script>

<PageHeader title="Categories">
  <Navigate to="/admin/categories/new" styles="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add category
  </Navigate>
</PageHeader>

<ListCategories />
