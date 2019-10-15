<script>
  import { Navigate } from "svelte-router-spa";

  import SignupForm from "./form/index.svelte";

  export let params;
  export let currentRoute;
</script>

<div class="flex items-center justify-center h-screen w-screen bg-gray-600">
  <div class="w-3/4 shadow-lg rounded-lg bg-white md:w-1/2 lg:1/3">
    <h1 class="mt-6 text-2xl text-gray-700 text-center">Demanda E-commerce</h1>
    <div class="card-content">
      <p class="p-6 text-center text-lg ">Sign up</p>
      <SignupForm />
      <p class="p-6">
        Already have an account?
        <Navigate styles="text-link" to="login">Log in</Navigate>
      </p>
    </div>
  </div>
</div>
