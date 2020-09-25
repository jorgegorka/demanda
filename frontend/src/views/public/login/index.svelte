<script>
  import { Navigate } from "svelte-router-spa";

  import LoginForm from "./form/index.svelte";

  export let params;
  export let currentRoute;
</script>

<div
  class="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6
    lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-md">
    <h1
      class="mt-6 text-center text-3xl leading-9 font-extrabold text-gray-900">
      Demanda E-commerce
    </h1>
    <p class="mt-2 text-center text-sm leading-5 text-gray-600 max-w">
      Rails - Graphql - Svelte - TailwindCss - Open source
    </p>
  </div>

  <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-4">
      <LoginForm />

      <p class="mt-6 p-6">
        New user?&nbsp;
        <Navigate styles="text-link" to="signup">Create an account</Navigate>
      </p>
    </div>
  </div>
</div>
