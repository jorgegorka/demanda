<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListProducts from "./list/index.svelte";

  export let currentRoute;
  export let params;
</script>

<PageHeader title="Products">
  <Navigate to="/admin/products/new" styles="btn-primary">
    <svg viewBox="0 0 20 20" fill="currentColor" class="plus w-6 h-6">
      <path
        fill-rule="evenodd"
        d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
        clip-rule="evenodd" />
    </svg>
    Add product
  </Navigate>
</PageHeader>

<ListProducts />
