<script>
  import LanguageFinder from "../finder.svelte";

  export let currentRoute;
  export let params;

  $: languageId = currentRoute.namedParams.id;
</script>

<LanguageFinder {languageId} graphqlClient={params.graphqlClient} />
