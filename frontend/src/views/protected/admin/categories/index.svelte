<script>
  import PageHeader from "../../../components/protected/page_header.svelte";
  import ListCategories from "./list/index.svelte";
  import NewCategory from "./new/index.svelte";

  let showModal = false;

  function closeModal() {
    showModal = false;
  }
</script>

<PageHeader title="Categories">
  <a
    href="#!"
    on:click={() => (showModal = true)}
    class="btn primary flex align-middle">
    <i class="material-icons ">add</i>
    Add category
  </a>
</PageHeader>

<!-- <ListCategories /> -->

<NewCategory
  {showModal}
  on:closeModal={closeModal}
  on:cancelModal={closeModal} />
