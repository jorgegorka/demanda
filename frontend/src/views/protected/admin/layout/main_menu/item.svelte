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
    <i class="material-icons text-xl text-gray-600">{item.icon}</i>
    <span class="ml-3">{item.title}</span>
  </Navigate>
</li>
