<script>
  import { createEventDispatcher } from "svelte";

  import Header from "./header.svelte";
  import MediaList from "../../media/list/index.svelte";
  import TranslationsList from "../../translations/list/index.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import CategoryResults from "../results.svelte";

  export let category = {};

  const dispatch = createEventDispatcher();
  const parent = {
    id: category.id,
    type: "categories",
    name: category.name,
  };
</script>

<Header {category} />

<div class="mt-4">
  <MediaList attachments={category.attachments} {parent} />
</div>

<div class="mt-4">
  <TranslationsList translations={category.translations} {parent} />
</div>
