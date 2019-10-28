<script>
  import Loading from "../../../components/loading.svelte";
  import ShowLanguage from "./show/language.svelte";
  import EditLanguage from "./edit/language.svelte";
  import { LanguageModel } from "../../../../lib/models/language";

  export let languageId;
  export let graphqlClient;
  export let show = true;

  let language = LanguageModel().findOne(graphqlClient, languageId);

  $: language = LanguageModel().findOne(graphqlClient, languageId);
</script>

{#await $language}
  <Loading />
{:then result}
  {#if show}
    <ShowLanguage language={result.data.languages[0]} {graphqlClient} />
  {:else}
    <EditLanguage language={result.data.languages[0]} {graphqlClient} />
  {/if}
{:catch error}
  Error: {error}
{/await}
