<script>
  import { navigateTo } from "svelte-router-spa";

  import { UserSession } from "../../../../../lib/session/";

  function logout() {
    UserSession.remove();
  }
</script>

<div>
  <p>User</p>
  <ul>
    <li>
      <a href="#!" on:click={logout}>Log out</a>
    </li>
  </ul>
</div>
