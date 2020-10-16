<script>
  import SidebarItem from "../../../../components/admin/sidebar_item.svelte";
  import { clientMenuItems } from "../../../../../lib/menu/client";

  export let currentRoute = {};
</script>

<nav class="text-gray-800">
  <ul>
    {#each clientMenuItems as item, index (index)}
      <SidebarItem {item} {currentRoute} />
    {/each}
  </ul>
</nav>
