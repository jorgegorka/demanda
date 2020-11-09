<script>
  import { quartInOut } from "svelte/easing";
  import { slide } from "svelte/transition";

  import { UserSession } from "../../../../lib/session";
  import { currentUser } from "../../../../lib/stores/current_user";

  let show = false;

  function logout() {
    UserSession.remove();
  }
</script>

<div class="text-right h-full">
  <div id="dropdown" class="h-full mr-4 md:mr-8">
    <div class="flex items-center h-full" on:click={() => (show = !show)}>
      <img
        class="h-10 w-10 rounded-full flex-no-shrink"
        src="https://images.unsplash.com/photo-1541271696563-3be2f555fc4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=1.75&w=200&h=200&q=80"
        alt="" />
      <div class="ml-4">
        <p class="hidden md:block font-semibold text-gray-900 leading-none">
          {$currentUser.name}
        </p>
      </div>
    </div>
    {#if show}
      <div
        class="absolute inset-0 bg-transparent"
        on:click={() => (show = !show)} />
      <div
        in:slide={{ duration: 300, delay: 100, opacity: 0.5, start: 0.1, easing: quartInOut }}
        out:slide={{ duration: 200, delay: 100, opacity: 0.5, start: 0.5, easing: quartInOut }}
        class="mt-2 absolute right-0 origin-top-right">
        <div class="w-64 text-left bg-white rounded-lg shadow-lg">
          <div class="py-1">
            <a
              href="/user/profile"
              class="block px-6 py-3 leading-tight hover:bg-purple-200">
              My profile
            </a>
            <a
              href="/admin"
              class="block px-6 py-3 leading-tight hover:bg-purple-200">
              Admin area
            </a>
          </div>
          <div class="border-t-2 border-gray-200 py-1">
            <a
              href="/user"
              on:click|preventDefault={logout}
              class="block w-full px-6 py-3 text-left leading-tight
              hover:bg-purple-200">
              Log out
            </a>
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
