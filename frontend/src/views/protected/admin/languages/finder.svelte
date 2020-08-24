<script>
  import Loading from "../../../components/loading.svelte";
  import ShowLanguage from "./show/language.svelte";
  import EditLanguage from "./edit/language.svelte";
  import { LanguageModel } from "../../../../lib/models/language";

  export let languageId;
  export let show = true;

  let language = LanguageModel().findOne(languageId);

  $: language = LanguageModel().findOne(languageId);
</script>

{#await $language}
  <Loading />
{:then result}
  {#if show}
    <ShowLanguage language={result.data.languages[0]} />
  {:else}
    <EditLanguage language={result.data.languages[0]} />
  {/if}
{:catch error}
  Error: {error}
{/await}
