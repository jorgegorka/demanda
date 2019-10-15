<script>
  import { Navigate, routeIsActive } from "svelte-router-spa";

  export let item = {};
</script>

<li>
  <Navigate styles="sidebar-link" to={item.to}>
    <i class="material-icons text-gray-600">{item.icon}</i>
    <span class="ml-3">{item.title}</span>
  </Navigate>
</li>
