<script>
  import { currentUser } from "../../../../../lib/stores/current_user";
  import EditUser from "./user.svelte";
</script>

<EditUser user={$currentUser} />
