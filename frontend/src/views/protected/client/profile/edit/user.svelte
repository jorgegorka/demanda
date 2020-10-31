<script>
  import { navigateTo } from "svelte-router-spa";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import ProfileForm from "../form/index.svelte";
  import { User } from "../../../../../lib/models/user";
  import { currentUser } from "../../../../../lib/stores/current_user";

  export let user = {};

  let disableAction = false;
  let userProfile = {};

  $: userProfile = User($currentUser);

  function editProfile() {
    disableAction = true;
    if (userProfile.valid()) {
      userProfile.edit($currentUser.id).then(function (result) {
        disableAction = false;
        if (result.errors.length === 0) {
          navigateTo(`/user/dashboard`);
        }
      });
    } else {
      userProfile = { ...userProfile };
      disableAction = false;
    }
  }
</script>

<PageHeader title={user.name || 'Your profile'} />

<ProfileForm
  user={userProfile}
  submitText="Update profile"
  on:submit={editProfile}
  {disableAction} />
