<script>
  import LanguageFinder from "../finder.svelte";

  export let currentRoute;

  $: languageId = currentRoute.namedParams.id;
</script>

<LanguageFinder {languageId} />
