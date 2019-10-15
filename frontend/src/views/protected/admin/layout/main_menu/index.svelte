<script>
  import SidebarItem from "./item.svelte";
  import { adminMenuItems } from "../../../../../lib/menu/admin";
</script>

<nav class="text-gray-800">
  <ul>
    {#each adminMenuItems as item, index (index)}
      <SidebarItem {item} />
    {/each}
  </ul>
</nav>
