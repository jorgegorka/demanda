<script>
  import SidebarItem from "../../../../components/admin/sidebar_item.svelte";
  import { adminMenuItems } from "../../../../../lib/menu/admin";

  export let currentRoute = {};
</script>

<nav class="text-gray-800">
  <ul>
    {#each adminMenuItems as item, index (index)}
      <SidebarItem {item} {currentRoute} />
    {/each}
  </ul>
</nav>
