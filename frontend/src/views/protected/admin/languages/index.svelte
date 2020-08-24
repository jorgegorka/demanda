<script>
  import { Navigate } from "svelte-router-spa";

  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListLanguages from "./list/index.svelte";
</script>

<PageHeader title="Languages">
  <Navigate to="/admin/languages/new" styles="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add language
  </Navigate>
</PageHeader>

<ListLanguages />
