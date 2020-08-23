<script>
  import { Navigate, routeIsActive } from "svelte-router-spa";

  export let item = {};
  export let currentRoute = {};

  let isActive = "";

  $: if (currentRoute && item.to && routeIsActive(item.to, true)) {
    isActive = "active";
  } else {
    isActive = "";
  }
</script>

<li>
  <Navigate styles="sidebar-link {isActive}" to={item.to}>
    {@html item.icon}
    <span class="ml-3">{item.title}</span>
  </Navigate>
</li>
