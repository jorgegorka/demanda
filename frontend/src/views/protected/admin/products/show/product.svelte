<script>
  import { createEventDispatcher } from "svelte";

  import PageHeader from "../../../../components/protected/page_header.svelte";
  import Alert from "../../../../components/alert/index.svelte";
  import ProductDetails from "./details.svelte";
  import TranslationsList from "../../translations/list/index.svelte";
  import MediaList from "../../media/list/index.svelte";

  export let product = {};

  const dispatch = createEventDispatcher();
  const parent = {
    id: product.id,
    type: "products",
    name: product.name,
  };
</script>

<PageHeader title={product.name}>
  <div class="flex items-center">
    <a href={`/admin/products/edit/${product.id}`} class="btn-secondary">
      <svg viewBox="0 0 20 20" fill="currentColor" class="pencil w-6 h-6">
        <path
          d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3
          14.172V17h2.828l8.38-8.379-2.83-2.828z" />
      </svg>
      Edit product
    </a>
  </div>
</PageHeader>

<ProductDetails {product} />

<div class="mt-4">
  <MediaList attachments={product.attachments} {parent} />
</div>

<div class="mt-4">
  <TranslationsList translations={product.translations} {parent} />
</div>
